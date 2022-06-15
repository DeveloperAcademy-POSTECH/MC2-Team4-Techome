//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI

class TodayStatesHolder: ObservableObject {
    
    @Published var caffeinePercent: Double
    
    init() {
        caffeinePercent = 0.0
    }
}


struct TodayView: View {
    @State private var caffeinePercent: Double = 0.5
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundAnimationView(caffeinePercent: $caffeinePercent)
                VStack(spacing: .zero) {
                    TodayViewTopBottons(caffeinePercent: $caffeinePercent, geometry: geometry)
                        .padding(.top, TodayLayoutValue.Padding.Content.top)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.buttonsToRemainingState)
                    RemainingCaffeineStatement()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                    Spacer()
                    ExhaustTimeStatement()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.exhaustTimeToAddCaffeine)
                    AddCaffeineButton()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, TodayLayoutValue.Padding.Content.trailing)
                        .padding(.bottom, TodayLayoutValue.Padding.Content.bottom)
                }
            }
            .ignoresSafeArea()
            
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
