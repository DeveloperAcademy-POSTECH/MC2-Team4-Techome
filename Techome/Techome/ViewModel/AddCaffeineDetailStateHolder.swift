//
//  AddCaffeineDetailStateHolder.swift
//  Techome
//
//  Created by 한택환 on 2022/06/15.
//

import Foundation

final class AddCaffeineDetailStateHolder: ObservableObject {

    let intakeManager = IntakeManager.shared
    
    var beverge: Beverage
    @Published var selectedSizeInfo: SizeInfo
    @Published var addedShotCount: Int = 0
    
    init(beverage: Beverage, size: SizeInfo) {
        self.beverge = beverage
        //  first optional 처리
        selectedSizeInfo = size
    }
    
    
    func getDefaultShot() -> Int {
        return selectedSizeInfo.defaultShotCount
    }
    func getRemainCaffeineAmountCurrent() -> Double {
        return intakeManager.getRemainCaffeineAmount()
    }
    func getAddedCaffeineAmount() -> Int {
        return selectedSizeInfo.caffeineAmount + addedShotCount * beverge.franchise.getCaffeinPerShot()
    }
    func getRemainCaffeineAmountAfterDrink() -> Double {
        return getRemainCaffeineAmountCurrent() + Double(getAddedCaffeineAmount())
    }
    func getAddedTime() -> String {
        let seconds = intakeManager.getRemainTimeToDischarge(caffeine: getRemainCaffeineAmountAfterDrink()) - intakeManager.getRemainTimeToDischarge(caffeine: getRemainCaffeineAmountCurrent())
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        return "\(hours)시 \(minutes)분"
    }
    func getTimeToDischarge() -> String {
        let seconds = intakeManager.getRemainTimeToDischarge(caffeine: getRemainCaffeineAmountAfterDrink())
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        var dischargeTime = Calendar.current.date(byAdding: .hour, value: hours, to: Date()) ?? Date()
        dischargeTime = Calendar.current.date(byAdding: .minute, value: minutes, to: dischargeTime) ?? Date()
        
        return Formatter.remainingTime.string(from: dischargeTime)
    }
    
//    func calculatedHour(caffenineAmount: Int) -> Int {
//        let remainTimeToDischargeSecond: Int = intakeManager.getRemainTimeToDischarge(caffeine: Double(caffenineAmount))
//        let remainTimeToDischargeHour: Int = remainTimeToDischargeSecond / 3600
//        return remainTimeToDischargeHour
//    }
//
//    func calculatedMinute(caffenineAmount: Int) -> Int {
//        let remainTimeToDischargeSecond: Int = intakeManager.getRemainTimeToDischarge(caffeine: Double(caffenineAmount))
//        let remainTimeToDischargeMinute: Int = (remainTimeToDischargeSecond % 3600) / 60
//        return remainTimeToDischargeMinute
//    }
//
//    func calculateHours(second: Int) -> Int {
//        return second / 3600
//    }
//
//    func calculateMinutes(second: Int) -> Int {
//        return (second % 3600) / 60
//    }
//
//    func getRemainingTimeString() -> String {
//        let caffeineAmount = intakeManager.getRemainCaffeineAmount() + Double(getRemainCaffeineAmountAfterDrink())
//        let seconds = intakeManager.getRemainTimeToDischarge(caffeine: caffeineAmount)
//        print("caffeineAmount: \(caffeineAmount)")
//        print("seconds: \(seconds)")
//
//        let hours = calculateHours(second: seconds)
//        let minutes = calculateHours(second: seconds)
//        print("add: [\(hours):\(minutes)]")
//
//        var updatedDate = Calendar.current.date(byAdding: .hour, value: hours, to: Date()) ?? Date()
//        updatedDate = Calendar.current.date(byAdding: .minute, value: minutes, to: updatedDate) ?? Date()
//        return Formatter.remainingTime.string(from: updatedDate)
//    }
}
