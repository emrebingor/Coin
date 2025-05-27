//
//  ButtonView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/26/25.
//

import SwiftUI

struct AlSatButtonView: View {
    @EnvironmentObject var viewModel: AlSatViewModel
    var body: some View {
        Button {
            
        } label: {
            Text(viewModel.selectedTab == .kolayAl ? "BTC AL" : "BTC SAT")
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(.green1)
        .cornerRadius(6)
    }
}

#Preview {
    AlSatButtonView()
}
