//
//  TodayViewTopBottons.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct TodayViewTopBottons: View {
    @EnvironmentObject var todayStateHolder: TodayStatesHolder
    let geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: .zero) {
            Spacer()
            Button {
                todayStateHolder.isAddSideEffectView.toggle()
            } label: {
                Image("AddSideEffectViewIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: TodayLayoutValue.Size.addSideEffectButtonWidth)
                    .padding(.top, geometry.safeAreaInsets.top)
            }
            .padding(.trailing, TodayLayoutValue.Padding.TopButtons.vInterval)
            Button {
                todayStateHolder.isSettingView.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: TodayLayoutValue.Size.addSideEffectButtonWidth)
                    .padding(.top, geometry.safeAreaInsets.top)
                    .foregroundColor(.primaryBrown)
            }
            .sheet(isPresented: $todayStateHolder.isAddSideEffectView) {
                AddSideEffectView()
            }
            .sheet(isPresented: $todayStateHolder.isSettingView) {
                SettingsView()
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
