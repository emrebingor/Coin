//
//  ChartView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/16/25.
//

import SwiftUI

struct ChartView: View {
    @EnvironmentObject var viewModel: ViewModel
    let fiyatList: [Double] = (0..<16).map { _ in Double.random(in: 0...10000) }
    let miktarList: [Double] = (0..<16).map { _ in Double.random(in: 0...10000) }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                TextView(text: "Fiyat")
                    .frame(alignment: .leading)
                Spacer()
                TextView(text: "Miktar")
                    .frame(alignment: .trailing)
            }
            .padding(.bottom, 4)
            
            if viewModel.grapEnum == .decrease || viewModel.grapEnum == .all {
                ListView(prices: viewModel.getPriceList(from: fiyatList), color: Color.red1)
            }
            
            if viewModel.grapEnum == .all || viewModel.grapEnum == .increase {
                PriceView(color: viewModel.grapEnum == .increase ? Color.green1 : Color.red1)
                    .padding(.vertical, 8)
            }
            
            if viewModel.grapEnum == .increase || viewModel.grapEnum == .all {
                ListView(prices: viewModel.getPriceList(from: miktarList), color: Color.green1)
            }
            
            if viewModel.grapEnum == .decrease {
                PriceView(color: Color.red1)
                    .padding(.vertical, 8)
            }
            
            Button {
                withAnimation(.easeOut(duration: 0.5)) {
                    viewModel.updateGraphEnum()
                }
            } label: {
                Image(viewModel.grapEnum.imageName)
                    .padding(3)
                    .background(Color.gray)
                    .cornerRadius(4)
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    ChartView()
}

struct PriceView: View {
    
    var color: Color
    
    var body: some View {
        HStack {
            TextView(text: "99.999.99", color: color)
            Image("downArrow")
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(color, lineWidth: 1.5)
        )
    }
}

struct ListView: View {
    var prices: [Double]
    var color: Color
    
    var body: some View {
        ForEach(prices, id: \.self) { list in
            HStack {
                TextView(text: String(format: "%.2f", list), color: color)
                    .font(.system(size: 14, weight: .medium))
                    .frame(alignment: .leading)
                    .lineLimit(1)
                Spacer()
                TextView(text: String(format: "%.2f", list))
                    .font(.system(size: 14, weight: .medium))
                    .frame(alignment: .trailing)
                    .lineLimit(1)
            }
            .padding(.bottom, 3)
        }
        
    }
}
