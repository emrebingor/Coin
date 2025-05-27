//
//  TransactionView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/27/25.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    viewModel.updateSellStatus(transactionEnum: .al)
                }) {
                    Text("AL")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(viewModel.transactionEnum == .al ? .white : Color.gray7)
                        .background(viewModel.transactionEnum == .al ? Color.green1 : Color.gray3)
                }
                
                Button(action: {
                    viewModel.updateSellStatus(transactionEnum: .sat)
                }) {
                    Text("SAT")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(viewModel.transactionEnum == .sat ? .white : Color.gray7)
                        .background(viewModel.transactionEnum == .sat ? Color.red1 : Color.gray3)
                }
            }
            .cornerRadius(4)
            
            Spacer().frame(height: 8)

            HStack {
                Text(viewModel.selectedTransaction)
                Spacer()
                Image("Icon")
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(Color.gray3)
            .cornerRadius(4)
            .onTapGesture {
                viewModel.isSheetVisible = true
            }
            .padding(.bottom, 8)
            
            if viewModel.selectedTransaction == TransactionEnum.limit.rawValue {
                Text("999,999.99")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 14, weight: .medium))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .background(Color.gray1)
                    .foregroundColor(Color.gray8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray3, lineWidth: 1)
                    )
                    .cornerRadius(4)
                    .multilineTextAlignment(.leading)
                
                Spacer().frame(height: 8)
            }
            
            TextFieldView(title: "Miktar (BTC)", text: $viewModel.miktarAmountFieldText)
                .padding(.bottom, 8)
            
            if viewModel.selectedTransaction == TransactionEnum.stopLimit.rawValue || viewModel.selectedTransaction == TransactionEnum.stopPiyasa.rawValue  {
                TextFieldView(title: "Stop (TRY)", text: $viewModel.stopAmountFieldText)
                    .padding(.bottom, 8)
            }

            if viewModel.selectedTransaction == TransactionEnum.stopPiyasa.rawValue ||  viewModel.selectedTransaction == TransactionEnum.piyasa.rawValue {
                Text("999,999.99")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 14, weight: .medium))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color.gray7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray3, lineWidth: 1)
                    )
                    .cornerRadius(4)
                
                Spacer().frame(height: 8)
            }

            if viewModel.selectedTransaction == TransactionEnum.stopLimit.rawValue {
                TextFieldView(title: "Limit (TRY)", text: $viewModel.limitAmountFieldText)
                    .padding(.bottom, 8)
            }

            if viewModel.selectedTransaction != TransactionEnum.stopLimit.rawValue {
                TextFieldView(title: "Toplam (TRY)", text: $viewModel.amountFieldText)
                    .padding(.bottom, 8)
            }

            VStack(spacing: 8) {
                HStack(spacing: 2) {
                    ForEach(PercentageEnum.allCases.filter {$0 != .percent0}, id: \.self) { percentage in
                        Rectangle()
                            .fill(viewModel.selectedStep.rawValue >= percentage.rawValue ? Color.gray7 : Color.gray3)
                            .frame(height: 10)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(5)
                            .onTapGesture {
                                viewModel.calculatePercentagePrice(step: percentage)
                            }
                    }
                }
                
                HStack(spacing: 4) {
                    ForEach(PercentageEnum.allCases.filter {$0 != .percent0}, id: \.self) { percentage in
                        Text("%\(percentage.rawValue)")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color.gray8)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 8)
            
            if viewModel.selectedTransaction == TransactionEnum.stopLimit.rawValue {
                TextFieldView(title: "Miktar (BTC)", text: $viewModel.miktarAmountFieldText)
                    .padding(.bottom, 8)
            }

            AmountTextView(title: "Kullanılabilir", currency: "TRY", iconVisibility: true)
                .padding(.bottom, 4)

            AmountTextView(title: "Komisyon", currency: "BTC")
                .padding(.bottom, 4)

            AmountTextView(title: "ICPX İndirimi", currency: "BTC")

            if viewModel.selectedTransaction == TransactionEnum.piyasa.rawValue {
                AmountTextView(title: "Komisyon Tutarı", currency: "BTC")
                    .padding(.top, 4)
            }
            
            Spacer().frame(height: 8)
            
            Button {
                
            } label: {
                Text(viewModel.transactionEnum == .al ? "BTC AL" : "BTC SAT")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .foregroundColor(.white)
            .background(viewModel.transactionEnum == .al ? Color.green1 : Color.red1)
            .cornerRadius(6)
        }
    }
}

#Preview {
    TransactionView()
}

struct AmountTextView: View {
    
    var title: String
    var currency: String
    var iconVisibility: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .lineLimit(1)
            Spacer()
            Text("99,999")
                .font(.system(size: 12, weight: .medium))
                .lineLimit(1)
            
            Text(currency)
                .font(.system(size: 12, weight: .medium))
                .lineLimit(1)
            
            if iconVisibility {
                Image("plus")
                    .padding(.all, 2)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        }
    }
}

struct TextFieldView: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .background(Color.gray1)
            .foregroundColor(Color.gray7)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray3, lineWidth: 1)
            )
            .cornerRadius(4)
            .multilineTextAlignment(.leading)
    }
}
