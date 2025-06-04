//
//  ContentView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/16/25.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingSideMenu = false
    
    var body: some View {
        ZStack {
            NavigationStack {
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
                    
                    MapView()
                        .tabItem {
                            Label("Map", systemImage: "map.fill")
                        }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                isShowingSideMenu.toggle()
                            }
                        }) {
                            Image(systemName: "menucard")
                                .imageScale(.large)
                        }
                    }
                }
            }
            
            SideMenuView(isShowingSideNav: $isShowingSideMenu)
            
        }
    }
}

#Preview {
    ContentView()
}
