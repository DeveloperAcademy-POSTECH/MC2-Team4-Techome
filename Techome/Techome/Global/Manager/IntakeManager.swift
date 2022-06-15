//
//  IntakeRecordManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/10.
//

import Foundation

final class IntakeManager {
    static let shared = IntakeManager()
    private init() {}
    
    let repository = IntakeRepository()
    
    func addRecord(beverage: Beverage, addedShotCount: Int) {
        repository.addRecord(record: IntakeRecord(date: Date.now, beverage: beverage, addedShotCount: addedShotCount))
    }
    
    func getDailyRecords(date: Date) -> [IntakeRecord] {
        return repository.getDailyRecords(date: date)
    }
    
    func getAllRecords() -> [IntakeRecord] {
        return repository.getAllRecords()
    }
    
    func deleteRecord(intakeRecord: IntakeRecord) {
        repository.deleteRecord(intakeRecord: intakeRecord)
    }
    
    func getCaffeineAmount(record: IntakeRecord) -> Int {
        var caffenine = record.beverage.caffeineAmount
        caffenine += (record.beverage.franchise.getCaffeinPerShot() * record.addedShotCount)
        
        return caffenine
    }
    
    func getTodayIntakeCaffeineAmount() -> Int {
        let todayRecords = getDailyRecords(date: Date.now)
        
        var amount = 0
        for record in todayRecords {
            amount += getCaffeineAmount(record: record)
        }
        
        return amount
    }
    
    func getRemainTimeToDischarge() -> Int {
        let standard = 50.0
        let remainCaffeine = self.getRemainCaffeineAmount() + 0.1
        let halfLifeInSecond: Double = 4 * 60 * 60
        
        return Int((-log2(standard / Double(remainCaffeine)) * halfLifeInSecond))
    }
    
    func getRemainCaffeineAmount() -> Double {
        let day: Double = 24 * 60 * 60
        
        let records = getDailyRecords(date: Date.now)
                    + getDailyRecords(date: Date(timeIntervalSinceNow: -day))
                    + getDailyRecords(date: Date(timeIntervalSinceNow: -day * 2))
        
        var amount = 0.0
        for record in records {
            let remainCaffeine = self.calculateRemainCaffeine(date: record.date,
                                                              caffeine: IntakeManager.shared.getCaffeineAmount(record: record))
            amount += remainCaffeine
        }
        
        return amount
    }
    
    private func calculateRemainCaffeine(date: Date, caffeine: Int) -> Double {
        let timeInterval = Date.now.timeIntervalSince(date)
        let halfLifeInSecond: Double = 4 * 60 * 60
        
        return Double(caffeine) * pow(1 / 2, timeInterval / halfLifeInSecond)
    }
}
