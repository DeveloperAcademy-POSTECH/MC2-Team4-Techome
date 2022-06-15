//
//  AddCaffeineDetailStateHolder.swift
//  Techome
//
//  Created by 한택환 on 2022/06/15.
//

import Foundation

class AddCaffeineDetailStateHolder: ObservableObject {
    
    let beverageManager = BeverageManager.shared
    let intakeManager = IntakeManager.shared
    
    @Published var bevergeRecord: Beverage = dummyBeverages[0]
    @Published var isSelected: Int = 0
    @Published var shotCount: Int = 0
    @Published var addCaffeineAmount: Int = 0
    
    let currentCaffeineAmount: Int = IntakeManager.shared.getTodayIntakeCaffeineAmount()
    init() {
        self.shotCount = bevergeRecord.sizeInfo[isSelected].defaultShotCount
        self.addCaffeineAmount = bevergeRecord.sizeInfo[isSelected].caffeineAmount
    }
    
    func updateDefaultShot() -> Int {
        return bevergeRecord.sizeInfo[isSelected].defaultShotCount
    }
    func updateAddCaffeineAmount() -> Int {
        return bevergeRecord.sizeInfo[isSelected].caffeineAmount
    }
}
