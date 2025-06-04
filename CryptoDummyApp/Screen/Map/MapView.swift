import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.selectedPin.map { [$0] } ?? []) { pin in
                MapAnnotation(coordinate: pin.coordinate) {
                    Image("customPinIcon")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .shadow(radius: 6)
                        .offset(y: -20)
                }
            }
            .mapStyle(.standard)
            .edgesIgnoringSafeArea(.all)
            
            HStack {
                HStack {
                    TextField(
                        "Adres girin...",
                        text: $viewModel.address,
                    )
                    .autocorrectionDisabled()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(12)
                    
                    Image("searchIcon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                        .onTapGesture {
                            Task {
                                await viewModel.searchAddress(viewModel.address)
                            }
                        }
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding()
                .shadow(radius: 12)
                
                Image("pinpoint")
                    .padding(.all, 12)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(radius: 12)
                    .onTapGesture {
                        viewModel.centerToUserLocation()
                    }
            }
            .padding(.trailing, 18)
        }
        .alert("Konum erişimi kapalı", isPresented: $viewModel.isLocationWarning) {
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } label: {
                Text("Settings")
            }
        } message: {
            Text("asd. Lütfen ayarlardan konum iznini etkinleştirin.")
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                viewModel.checkLocationPermission()
            }
        }
    }
}

#Preview {
    MapView()
}
