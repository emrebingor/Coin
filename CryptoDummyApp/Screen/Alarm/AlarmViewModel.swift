//
//  AlarmViewModel.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/22/25.
//

import Foundation

class AlarmViewModel: ObservableObject {
    @Published var fiyatText: Double = 100
    @Published var changedPriceText: Double = 0
    @Published var sliderValue: Double = 0
    @Published var alarmList: [Double] = []
    
    func changedPrice(newValue: Double) {
        let newPrice = (100 * (newValue / 100))
        self.changedPriceText = self.fiyatText + newPrice
    }
    
    func addAlarm() {
        self.alarmList.append(changedPriceText)
    }
    
    func deleteAlarm(index: Int) {
        self.alarmList.remove(at: index)
    }
}
