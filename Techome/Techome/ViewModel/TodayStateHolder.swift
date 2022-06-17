//
//  TodayStateHolder.swift
//  Techome
//
//  Created by Noah Park on 2022/06/16.
//

import Foundation

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
        var returnChargeAmount: Double {
            remainingAmount > fullChargeAmount ? fullChargeAmount : remainingAmount
        }
        return (returnChargeAmount / fullChargeAmount)
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
