//
//  AddCaffeineDetailStateHolder.swift
//  Techome
//
//  Created by 한택환 on 2022/06/15.
//

import Foundation

final class AddCaffeineDetailStateHolder: ObservableObject {

    let intakeManager = IntakeManager.shared
    
    @Published var beverge: Beverage
    @Published var isSelected: Int = 0
    @Published var shotCount: Int = 0
    @Published var defaultCaffeineAmount: Int = 0
    @Published var addedShotCount: Int = 0
    var currentCaffeineAmount: Int
    
    init(beverage: Beverage) {
        self.beverge = beverage
        self.currentCaffeineAmount = intakeManager.getTodayIntakeCaffeineAmount()
        self.shotCount = beverge.sizeInfo[isSelected].defaultShotCount
        self.defaultCaffeineAmount = beverage.sizeInfo[isSelected].caffeineAmount
    }
    
    
    func getDefaultShot() -> Int {
        guard isSelected < beverge.sizeInfo.count else {
            return 0
        }
        return beverge.sizeInfo[isSelected].defaultShotCount
    }
    func getWillAddCaffeineAmount() -> Int {
        guard isSelected < beverge.sizeInfo.count else {
            return 0
        }
        return beverge.sizeInfo[isSelected].caffeineAmount
    }
    func calculatedHour(caffenineAmount: Int) -> Int {
        let remainTimeToDischargeSecond: Int = intakeManager.getRemainTimeToDischarge(caffeine: Double(caffenineAmount))
        let remainTimeToDischargeHour: Int = remainTimeToDischargeSecond / 3600
        return remainTimeToDischargeHour
    }
    
    func calculatedMinute(caffenineAmount: Int) -> Int {
        let remainTimeToDischargeSecond: Int = intakeManager.getRemainTimeToDischarge(caffeine: Double(caffenineAmount))
        let remainTimeToDischargeMinute: Int = (remainTimeToDischargeSecond % 3600) / 60
        return remainTimeToDischargeMinute
    }
}
