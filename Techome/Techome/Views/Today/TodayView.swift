//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI
import Combine

struct TodayView: View {
    @EnvironmentObject var todayStates: TodayStatesHolder
    private let refreshInterval: TimeInterval = 60
    private let refreshTolerance: TimeInterval = 3
    private var refreshTimer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: refreshInterval, tolerance: refreshTolerance, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundAnimationView(todayStates: todayStates, geometry: geometry)
                VStack(spacing: .zero) {
                    TodayViewTopBottons(geometry: geometry)
                        .padding(.top, TodayLayoutValue.Padding.Content.top)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.buttonsToRemainingState)
                        .environmentObject(todayStates)
                    RemainingCaffeineStatement(todayStates: todayStates)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                    Spacer()
                    ExhaustTimeStatement(todayStates: todayStates)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.exhaustTimeToAddCaffeine)
                    AddCaffeineButton_q(todayStates: todayStates)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.bottom)
                        .environmentObject(todayStates)
                }
            }
            .ignoresSafeArea()
            .onReceive(refreshTimer) { _ in
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
