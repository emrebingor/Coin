//
//  ContentView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/16/25.
//

import SwiftUI

struct PiyasaScreenView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextView(text: "BTC/TRY")
                    IconView(image: "Icon")
                    TextView(text: "+99.99 %", color: Color.green1)
                    Spacer()
                    IconView(image: "Shape")
                    IconView(image: "Icn_Fav")
                }
                .padding(.bottom, 10)
                
                Divider()
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .padding(.bottom, 10)
                
                HStack(alignment: .top) {
                    ChartView()
                        .environmentObject(viewModel)
                    
                    Spacer().frame(width: 12)
                    
                    TransactionView()
                        .environmentObject(viewModel)
                }
            }
        }
        .sheet(isPresented: $viewModel.isSheetVisible) {
            BottomSheetView(viewModel: viewModel)
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
}

struct IconView: View {
    var image: String
    
    var body: some View {
        Image(image)
    }
}

struct TextView: View {
    var text: String
    var color: Color?
    
    var body: some View {
        Text(text)
            .foregroundColor(color ?? .black)
    }
}
