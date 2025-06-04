import Foundation
import MapKit

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var address = ""
    @Published var isLocationWarning = false
    @Published var selectedPin: MapPin?
    private let manager = CLLocationManager()
    
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func checkLocationPermission() {
        let status = manager.authorizationStatus
        if status == .denied || status == .restricted {
            self.isLocationWarning = true
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            self.isLocationWarning = true
            setDefaultLocation()
        case .notDetermined:
            break
        @unknown default:
            setDefaultLocation()
        }
    }
    
    func centerToUserLocation() {
        guard let location = manager.location else { return }
        
        DispatchQueue.main.async {
            let coordinate = location.coordinate
            self.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            )
            self.selectedPin = MapPin(coordinate: coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.region.center = location.coordinate
            self.selectedPin = MapPin(coordinate: location.coordinate)
        }
        
        manager.stopUpdatingLocation()
    }
    
    @MainActor
    func searchAddress(_ address: String) async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = address
        let search = MKLocalSearch(request: request)

        let response = try? await search.start()
        guard let coordinate = response?.mapItems.first?.placemark.coordinate else { return }

        self.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        )
        self.selectedPin = MapPin(coordinate: coordinate)
    }
    
    private func setDefaultLocation() {
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784),
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            )
        }
    }
}
