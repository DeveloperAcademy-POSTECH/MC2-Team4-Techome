//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI

struct TodayLayoutValue {
    struct Padding {
        enum Content {
            static let leading: CGFloat = 30.0
            static let trailing: CGFloat = 30.0
            static let top: CGFloat = 9.0
            static let bottom: CGFloat = 100.0
            static let buttonsToRemainingState: CGFloat = 25.0
            static let exhaustTimeToAddCaffeine: CGFloat = 40.0
        }
        enum topButtons {
            static let interval: CGFloat = 18.0
        }
        enum RemainingStatement {
            static let textVInterval: CGFloat = 8.0
        }
    }
    
    struct Size {
        static let addSideEffectButtonWidth: CGFloat = 35
        static let addSettingButtonWidth: CGFloat = 31
        static let remainingTextSize: CGFloat = 53.0
        static let exhaustTextSize: CGFloat = 53.0
        static let addCaffeineButtonWidth: CGFloat = 200.0
        static let addCaffeineButtonRatio: CGSize = CGSize(width: 4.0, height: 1.0)
    }
    
    struct Radius {
        static let addCaffeineButton: CGFloat = 7.0
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
