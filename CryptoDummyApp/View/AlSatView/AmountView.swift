//
//  AmountView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/26/25.
//

import SwiftUI

struct AmountView: View {
    @EnvironmentObject var viewModel: AlSatViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image("btcIcon")
                Text("Bitcoin - BTC/TRY")
                Spacer()
            }
            
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(Color.gray1)
                .padding(.bottom, 10)
            
            HStack(alignment: .bottom, spacing: 4) {
                Text(viewModel.formattedInput)
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
    }
}

#Preview {
    AmountView()
}
