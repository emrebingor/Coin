//
//  AlarmView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/22/25.
//

import SwiftUI

struct AlarmView: View {
    
    @StateObject var viewModel = AlarmViewModel()

    let range: ClosedRange<Double> = -99...99
    var body: some View {
        VStack(spacing: 0) {
            
            Text(String(format: "%.f", viewModel.fiyatText))
                .font(.system(size: 22, weight: .medium))
            
            Spacer().frame(height: 16)
            
            HStack {
                Text("Alarm Fiyatı")
                    .font(.system(size: 14, weight: .medium))
                Spacer()
                
                if viewModel.changedPriceText != 0 {
                    Image(viewModel.changedPriceText > viewModel.fiyatText ? "increaseArrow" : "decreaseArrow")
                }
                
                if viewModel.changedPriceText != 0 {
                    Text(viewModel.changedPriceText > viewModel.fiyatText ? "Arttığında" : "Düştüğünde")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(viewModel.changedPriceText > viewModel.fiyatText ? Color.green1 : Color.red1)
                }
            }
            
            Spacer().frame(height: 8)
            
            HStack {
                Text(viewModel.changedPriceText == 0 ? "Fiyat" : String(format: "%.f", viewModel.changedPriceText))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.gray7)
                Spacer()
                Text("TRY")
            }
            .padding(.all, 8)
            .background(Color.gray1)
            
            Spacer().frame(height: 16)

            VStack {
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width
                    let progress = CGFloat((viewModel.sliderValue - range.lowerBound) / (range.upperBound - range.lowerBound))
                    let labelOffset = progress * totalWidth

                    if viewModel.sliderValue != 0 {
                        PriceLabelBubble(value: viewModel.sliderValue)
                            .offset(x: viewModel.sliderValue > 0 ? labelOffset - 28 : labelOffset - 18, y: -5)
                    }
                }

                ZStack {
                    let tickCount = 9
                    let tickValues = stride(
                        from: range.lowerBound,
                        through: range.upperBound,
                        by: (range.upperBound - range.lowerBound) / Double(tickCount - 1)
                    ).map { $0 }

                    HStack(spacing: 0) {
                        ForEach(0..<tickCount, id: \.self) { i in
                            let tickValue = tickValues[i]

                            let color: Color = {
                                if viewModel.sliderValue < 0 {
                                    return tickValue >= viewModel.sliderValue && tickValue <= 0 ? .red : .gray
                                } else if viewModel.sliderValue > 0 {
                                    return tickValue <= viewModel.sliderValue && tickValue >= 0 ? .green : .gray
                                } else {
                                    return .gray
                                }
                            }()

                            Rectangle()
                                .fill(color)
                                .frame(width: 2, height: 16)

                            if i != tickCount - 1 {
                                Spacer()
                            }
                        }
                    }

                    CustomThumbSlider(value: $viewModel.sliderValue, range: range)
                        .onChange(of: viewModel.sliderValue) { newValue in
                            viewModel.changedPrice(newValue: newValue)
                        }
                }
            }
            .frame(height: 54)

            Spacer().frame(height: 16)
            
            AlarmButtonView()
                .environmentObject(viewModel)
            
            Spacer().frame(height: 16)

            if viewModel.alarmList.isEmpty {
                EmptyAlarmView()
            } else {
                AlarmListView()
                    .environmentObject(viewModel)
            }
        
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AlarmView()
}
