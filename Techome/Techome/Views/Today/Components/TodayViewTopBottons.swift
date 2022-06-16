//
//  TodayViewTopBottons.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct TodayViewTopBottons: View {
    let geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: .zero) {
            Spacer()
            Button {
                // TODO: add sideEffect button pressed
            } label: {
                Image("AddSideEffectViewIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: TodayLayoutValue.Size.addSideEffectButtonWidth)
                    .padding(.top, geometry.safeAreaInsets.top)
            }
            .padding(.trailing, TodayLayoutValue.Padding.topButtons.interval)
            Button {
                // TODO: add setting button pressed
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
            TodayViewTopBottons(geometry: geometry)
        }
        .previewLayout(.sizeThatFits)
    }
}
