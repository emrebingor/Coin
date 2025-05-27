//
//  ContentView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PiyasaScreenView()
                .tabItem {
                    Label("Piyasa", systemImage: "bitcoinsign.circle")
                }
            AlarmView()
                .tabItem {
                    Label("Alarm", systemImage: "alarm.fill")
                }
            
            AlSatView()
                .tabItem {
                    Label("Al-Sat", systemImage: "bitcoinsign.bank.building")
                }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
