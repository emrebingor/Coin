//
//  BottomSheetView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/16/25.
//

import SwiftUI

struct BottomSheetView: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    viewModel.isSheetVisible = false
                } label: {
                    Image(systemName: "xmark")
                }
                .padding(.top, 12)
                .padding(.trailing, 16)
                .foregroundColor(.black)
            }
            List(viewModel.transactionType, id: \.self) { transactionType in
                Button {
                    viewModel.updateSelectedTransaction(selectedTransaction: transactionType)
                } label : {
                    TextView(text: transactionType)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    BottomSheetView(viewModel: ViewModel())
}
