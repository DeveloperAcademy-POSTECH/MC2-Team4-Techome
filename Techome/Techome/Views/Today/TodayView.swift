//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI

final class TodayStatesHolder: ObservableObject {
    
    @Published var remainingAmount: Double
    
    private let intakeManager = IntakeManager.shared
    private let fullChargeAmount: Double = 1000 // TODO: 팀원 합의 필요
    
    init() {
        remainingAmount = intakeManager.getRemainCaffeineAmount()
    }
    
    func setRemainingAmount() {
        remainingAmount = intakeManager.getRemainCaffeineAmount()
    }
    
    func getTodyIntakeAmount() -> Int {
        return intakeManager.getTodayIntakeCaffeineAmount()
    }
    
    func getRemainingPercentage() -> Double {
        return (remainingAmount / fullChargeAmount)
    }
    
    func getRemainingTimeString() -> String {
        let seconds = intakeManager.getRemainTimeToDischarge()
        let hour = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let today = Date()
        
        var updatedDate = Calendar.current.date(byAdding: .hour, value: hour, to: today) ?? Date()
        updatedDate = Calendar.current.date(byAdding: .minute, value: minutes, to: updatedDate) ?? Date()
        return Formatter.remainingTime.string(from: updatedDate)
    }
}


struct TodayView: View {
    @State private var caffeinePercent: Double = 0.5
    @EnvironmentObject var todayStates: TodayStatesHolder
    
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
