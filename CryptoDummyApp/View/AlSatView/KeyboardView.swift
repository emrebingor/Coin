//
//  KeyboardView.swift
//  CryptoDummyApp
//
//  Created by Emre Bingor on 5/26/25.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var viewModel: AlSatViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.buttons, id: \.self) { row in
                HStack(spacing: 45) {
                    ForEach(row, id: \.self) { button in
                        if button == "delete" {
                            Image("numberDelete")
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.gray8)
                                .onTapGesture {
                                    viewModel.buttonTap(button)
                                }
                        } else {
                            Text(button)
                                .font(.system(size: 28, weight: .medium))
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.gray8)
                                .onTapGesture {
                                    viewModel.buttonTap(button)
                                }
                        }
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 36)
        .padding(.vertical, 8)
        .background(Color.gray1)
        .cornerRadius(16)
    }
}

#Preview {
    KeyboardView()
}
