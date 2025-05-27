//
//  AlSatViewModel.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/26/25.
//

import Foundation

class AlSatViewModel: ObservableObject {
    @Published var selectedTab: Tab = .kolayAl
    @Published var price: String = ""
}
