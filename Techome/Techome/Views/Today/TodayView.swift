//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI

struct TodayView: View {
    @ObservedObject private var todayStates: TodayStatesHolder = TodayStatesHolder()
    private let timer = Timer.publish(every: 60, tolerance: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundAnimationView(todayStates: todayStates, geometry: geometry)
                VStack(spacing: .zero) {
                    TodayViewTopBottons(geometry: geometry)
                        .padding(.top, TodayLayoutValue.Padding.Content.top)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.buttonsToRemainingState)
                    RemainingCaffeineStatement(todayStates: todayStates)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                    Spacer()
                    ExhaustTimeStatement(todayStates: todayStates)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.exhaustTimeToAddCaffeine)
                    AddCaffeineButton(todayStates: todayStates)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.bottom)
                }
            }
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                todayStates.setRemainingAmount()
            }
            
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let todayStates = TodayStatesHolder()
        TodayView()
            .environmentObject(todayStates)
    }
}
