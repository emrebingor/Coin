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

            VStack {
               AmountView()
                    .environmentObject(viewModel)

                Spacer()
                
                VStack {
                    ForEach(viewModel.buttons, id: \.self) { row in
                        HStack(spacing: 45) {
                            ForEach(row, id: \.self) { button in
                                Text(button)
                                    .font(.system(size: 28, weight: .medium))
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color.gray8)
                                    .cornerRadius(12)
                                    .onTapGesture {
                                        viewModel.buttonTap(button)
                                    }
                            }
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 36)
                .padding(.vertical, 8)
                .background(Color.gray1)
                .cornerRadius(16)

                Spacer().frame(height: 16)
                
                AlSatButtonView()
                    .environmentObject(viewModel)
            }
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

#Preview {
    AlSatView()
}
