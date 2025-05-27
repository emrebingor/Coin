import SwiftUI

struct AlSatView: View {
    
    @StateObject var viewModel = AlSatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                tabButton(title: "Kolay Al", tab: .kolayAl)
                tabButton(title: "Kolay Sat", tab: .kolaySat)
            }
            .frame(height: 50)

            HStack(spacing: 0) {
                Rectangle()
                    .fill(viewModel.selectedTab == .kolayAl ? Color.green1 : Color.clear)
                    .frame(height: 2)
                Rectangle()
                    .fill(viewModel.selectedTab == .kolaySat ? Color.green1 : Color.clear)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray4)

            AlSat()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }

    func tabButton(title: String, tab: Tab) -> some View {
        Button {
            viewModel.selectedTab = tab
        } label: {
            Text(title)
                .foregroundColor(viewModel.selectedTab == tab ? Color.green1 : Color.gray7)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AlSat: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("btcIcon")
                    Text("Bitcoin - BTC/TRY")
                    Spacer()
                }
                
                Divider()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .padding(.bottom, 10)
                
                HStack(alignment: .bottom, spacing: 4) {
                    Text("2,370.42")
                        .font(.system(size: 36, weight: .semibold))
                            .foregroundColor(Color.gray8)
                    Text("TL")
                        .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.gray8)
                }
            }
            .padding(.all, 16)
            .frame(maxWidth: .infinity)
            .background(Color.gray1)
            .cornerRadius(16)

            Spacer()
            
            Button {
                
            } label: {
                Text("BTC AL")
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(.green1)
            .cornerRadius(6)
        }
    }
}

#Preview {
    AlSatView()
}
