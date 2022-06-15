//
//  AddCaffeineButton.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct AddCaffeineButton: View {
    var body: some View {
        VStack(spacing: .zero) {
            Button {
                // TODO: modal addCaffeine view
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: TodayLayoutValue.Radius.addCaffeineButton)
                        .aspectRatio(TodayLayoutValue.Size.addCaffeineButtonRatio, contentMode: .fit)
                        .frame(width: TodayLayoutValue.Size.addCaffeineButtonWidth)
                        .foregroundColor(.primaryBrown)
                    Text("카페인 추가하기")
                        .font(.body.bold())
                        .foregroundColor(.white)
                }
                
            }
            .padding(.bottom, 10)
            Text("오늘 총 300mg 섭취")
                .font(.caption)
        }
    }
}

struct AddCaffeineButton_Previews: PreviewProvider {
    static var previews: some View {
        AddCaffeineButton()
    }
}
