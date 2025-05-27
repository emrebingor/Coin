//
//  AlSatViewModel.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/26/25.
//

import Foundation

enum Tab {
    case kolayAl
    case kolaySat
}

class AlSatViewModel: ObservableObject {
    @Published var selectedTab: Tab = .kolayAl
}
