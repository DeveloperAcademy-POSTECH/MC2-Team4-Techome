//
//  AddCaffeineButton.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct TodayAddCaffeineButton: View {
    @ObservedObject var todayStates: TodayStatesHolder
    
    var body: some View {
        VStack(spacing: .zero) {
            Button {
                todayStates.isSearchCaffeineView.toggle()
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
            .padding(.bottom, TodayLayoutValue.Padding.BottomButton.hInterval)
            .fullScreenCover(isPresented: $todayStates.isSearchCaffeineView) {
                SearchCaffeineView()
            }
            Text("오늘 총 \(todayStates.getTodayIntakeAmount())mg 섭취")
                .font(.caption)
        }
    }
}

struct AddCaffeineButton_Previews: PreviewProvider {
    static var previews: some View {
        let todayStates: TodayStatesHolder = TodayStatesHolder()
        TodayAddCaffeineButton(todayStates: todayStates)
            .previewLayout(.sizeThatFits)
    }
}
