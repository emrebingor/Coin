import SwiftUI

struct CustomThumbSlider: View {
    @EnvironmentObject var viewModel: AlarmViewModel
    var range: ClosedRange<Double>

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let width = geometry.size.width
                let midX = width / 2
                let totalRange = range.upperBound - range.lowerBound
                let normalized = CGFloat((viewModel.sliderValue - range.lowerBound) / totalRange)
                let currentX = normalized * width
                
                Capsule()
                    .fill(Color.gray4)
                    .frame(height: 2)
                    .position(x: midX, y: 15)
                
                if viewModel.sliderValue < 0 {
                    let redWidth = midX - currentX
                    Capsule()
                        .fill(Color.red1)
                        .frame(width: redWidth, height: 2)
                        .position(x: midX - redWidth / 2, y: 15)
                } else if viewModel.sliderValue > 0 {
                    let greenWidth = currentX - midX
                    Capsule()
                        .fill(Color.green1)
                        .frame(width: greenWidth, height: 2)
                        .position(x: midX + greenWidth / 2, y: 15)
                }
            }
            
            Slider(
                value: $viewModel.sliderValue,
                in: range,
                step: 1
            )
            .accentColor(.clear)
            .onChange(of: viewModel.sliderValue) { newValue in
                viewModel.changedPrice(newValue: newValue)
            }
        }
    }
}
