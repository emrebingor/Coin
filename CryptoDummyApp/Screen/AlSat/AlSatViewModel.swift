//
//  AlSatViewModel.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/26/25.
//

import Foundation

class AlSatViewModel: ObservableObject {	
    @Published var selectedTab: Tab = .kolayAl
    @Published var input: String = ""
    
    let buttons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "delete"]
    ]
    
    func buttonTap(_ value: String) {
        switch value {
        case "delete":
            if !input.isEmpty {
                input.removeLast()
            }
        case ".":
            break
        default:
            if value.allSatisfy(\.isNumber) {
                if input.count < 12 {
                    input += value
                }
            }
        }
    }
    
    var formattedInput: String {
        guard !input.isEmpty else { return "" }

        let sanitized = input.filter { $0.isNumber }

        let intPart = sanitized.dropLast(2)
        let decimalPart = sanitized.suffix(2)

        let intPartString = formatToDecimal(String(intPart.isEmpty ? "0" : intPart))
        return "\(intPartString),\(decimalPart.count == 1 ? "0\(decimalPart)" : decimalPart)"
    }

    private func formatToDecimal(_ value: String) -> String {
        let number = Int(value) ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter.string(from: NSNumber(value: number)) ?? value
    }
}
