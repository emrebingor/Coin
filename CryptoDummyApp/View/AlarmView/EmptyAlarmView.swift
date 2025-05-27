//
//  EmptyAlarmView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/22/25.
//

import SwiftUI

struct EmptyAlarmView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("BTC/TRY Alarmları")
                .padding(.bottom, 8)
            
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(Color.gray4)
                .padding(.bottom, 10)
            
            Spacer().frame(height: 83)
            
            Image("noAlert")
                .padding(.all, 24)
                .overlay(
                    Circle()
                        .stroke(Color.gray4, lineWidth: 2)
                )
            
            Spacer().frame(height: 16)

            Text("Oluşturulmuş alarm yoktur")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 332)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray1)
        .cornerRadius(4)
    }
}

#Preview {
    EmptyAlarmView()
}
