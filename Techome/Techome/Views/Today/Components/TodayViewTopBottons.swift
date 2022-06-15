//
//  TodayViewTopBottons.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct TodayViewTopBottons: View {
    @Binding var caffeinePercent: Double
    let geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: .zero) {
            Spacer()
            Button {
                print("add sideEffect button pressed")
                caffeinePercent -= 0.1 // 애니메이션 Test를 위한 임시 로직)
            } label: {
                Image("AddSideEffectViewIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: TodayLayoutValue.Size.addSideEffectButtonWidth)
                    .padding(.top, geometry.safeAreaInsets.top)
            }
            .padding(.trailing, TodayLayoutValue.Padding.topButtons.interval)
            Button {
                print("add setting button pressed")
                caffeinePercent += 0.1 // 애니메이션 Test를 위한 임시 로직
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: TodayLayoutValue.Size.addSideEffectButtonWidth)
                    .padding(.top, geometry.safeAreaInsets.top)
                    .foregroundColor(.primaryBrown)
            }
        }
    }
}

struct TodayViewTopBottons_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            TodayViewTopBottons(caffeinePercent: .constant(0.5), geometry: geometry)
        }
    }
}
