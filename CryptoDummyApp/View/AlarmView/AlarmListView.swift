//
//  AlarmListView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/22/25.
//

import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var viewModel: AlarmViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Fiyat")
                .padding(.bottom, 4)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.gray7)
            
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(Color.gray1)
                .padding(.bottom, 10)
            
            List {
                ForEach(Array(viewModel.alarmList.enumerated()), id: \.element) { index, price in
                    VStack {
                        HStack(spacing: 0) {
                            Image(price < viewModel.fiyatText ? "decreaseArrow" : "increaseArrow")
                            
                            Spacer().frame(width: 6)

                            Text(String(price))
                            
                            Spacer()
                            
                            Image("iconDelete")
                                .onTapGesture {
                                    viewModel.deleteAlarm(index: index)
                                }
                        }
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray1)
                            .padding(.bottom, 10)
                    }
                    .frame(height: 45)

                }
                .listRowInsets(EdgeInsets())
                .background(Color.gray1)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: 268)
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color.gray1)
        .cornerRadius(4)
    }
}

#Preview {
    AlarmListView()
}
