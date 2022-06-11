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
    
    func addRecord(beverage: Beverage) {
        repository.addRecord(record: IntakeRecord(date: Date.now, beverage: beverage))
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
    
    func getTodayIntakeCaffeineAmount() -> Int {
        let todayRecords = getDailyRecords(date: Date.now)
        
        var amount = 0
        for record in todayRecords {
            amount += record.beverage.caffeineAmount
        }
        
        return amount
    }
    
    func getRemainTimeToDischarge() -> Int {
        let standard = 50.0
        let remainCaffeine = self.getRemainCaffeineAmount()
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
                                                              caffeine: record.beverage.caffeineAmount)
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
