//
//  AlarmButtonView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/22/25.
//

import SwiftUI

struct AlarmButtonView: View {
    @EnvironmentObject var viewModel: AlarmViewModel
    
    var body: some View {
        Button {
            viewModel.addAlarm()
        } label: {
            Text("Alarm Oluştur")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .foregroundColor(viewModel.sliderValue == 0 ? Color.gray7 : .white)
        .background(viewModel.sliderValue == 0 ? Color.gray4 : Color.orange1)
        .cornerRadius(6)
    }
}

#Preview {
    AlarmButtonView()
}
