//
//  ViewModel.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/16/25.
//

import Foundation

enum Transaction {
    case al
    case sat
}

class ViewModel: ObservableObject {
    @Published var isSheetVisible: Bool = false
    @Published var balance: Double = 150.0
    @Published var amountFieldText: String = ""
    @Published var stopAmountFieldText: String = ""
    @Published var limitAmountFieldText: String = ""
    @Published var miktarAmountFieldText: String = ""
    @Published var selectedStep: PercentageEnum = .percent25
    @Published var selectedTransaction: String = "Piyasa"
    @Published var transactionType: [String] = ["Piyasa", "Limit", "Stop-Piyasa", "Stop-Limit"]
    @Published var isSell: Bool = false
    @Published var transactionEnum: Transaction = .al
    @Published var grapEnum: GraphEnum = .all
    
    func calculatePercentagePrice(step: PercentageEnum) {
        if self.selectedStep == step {
            self.selectedStep = .percent0
            self.amountFieldText = ""
        } else {
            self.selectedStep = step
            self.amountFieldText = String(format: "%.2f", (self.balance * Double(self.selectedStep.rawValue)) / 100)
        }
    }
    
    func updateSelectedTransaction(selectedTransaction: String) {
        self.isSheetVisible = false
        self.selectedTransaction = selectedTransaction
    }
    
    func updateSellStatus(transactionEnum: Transaction) {
        self.transactionEnum = transactionEnum
    }
    
    func updateGraphEnum() {
        switch grapEnum {
        case .all:
            self.grapEnum = .increase
        case .decrease:
            self.grapEnum = .all
        case .increase:
            self.grapEnum = .decrease
        }
    }
    
    func getPriceList(from source: [Double]) -> [Double] {
        let isStop = selectedTransaction == TransactionEnum.stopLimit.rawValue || selectedTransaction == TransactionEnum.stopPiyasa.rawValue
        let isLimit = selectedTransaction == TransactionEnum.limit.rawValue
        
        if grapEnum == .all {
            return isStop ? Array(source.prefix(8)) : Array(source.prefix(7))
        } else {
            return isStop ? source : isLimit ? Array(source.prefix(13)) : Array(source.prefix(14))
        }
    }
}
