//
//  AddCaffeineDetailStateHolder.swift
//  Techome
//
//  Created by 한택환 on 2022/06/15.
//

import Foundation

final class AddCaffeineDetailStateHolder: ObservableObject {

    let intakeManager = IntakeManager.shared
    
    @Published var bevergeRecord: Beverage = dummyBeverages[0]
    @Published var isSelected: Int = 0
    @Published var shotCount: Int = 0
    @Published var addCaffeineAmount: Int = 0
    var currentCaffeineAmount: Int
    
    init() {
        self.currentCaffeineAmount = intakeManager.getTodayIntakeCaffeineAmount()
        self.shotCount = bevergeRecord.sizeInfo[isSelected].defaultShotCount
        self.addCaffeineAmount = bevergeRecord.sizeInfo[isSelected].caffeineAmount
    }
    
    func getDefaultShot() -> Int {
        guard isSelected >= bevergeRecord.sizeInfo.count else {
            return 0
        }
        return bevergeRecord.sizeInfo[isSelected].defaultShotCount
    }
    func getWillAddCaffeineAmount() -> Int {
        guard isSelected >= bevergeRecord.sizeInfo.count else {
            return 0
        }
        return bevergeRecord.sizeInfo[isSelected].caffeineAmount
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
