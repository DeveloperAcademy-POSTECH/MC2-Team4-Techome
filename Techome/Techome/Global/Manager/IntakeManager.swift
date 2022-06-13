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
    
    func addRecord(beverage: Beverage, sizeInfo: SizeInfo,addedShotCount: Int) {
        repository.save(record: IntakeRecord(date: Date.now,
                                                  beverage: beverage,
                                                  size: sizeInfo,
                                                  addedShotCount: addedShotCount))
    }
    
    func getDailyRecords(date: Date) -> [IntakeRecord] {
        return repository.findByDate(date: date)
    }
    
    func getRecentRecords(count: Int) -> [IntakeRecord] {
        return repository.findRecent(count: count)
    }
    
    func getAllRecords() -> [IntakeRecord] {
        return repository.findAll()
    }
    
    func deleteRecord(intakeRecord: IntakeRecord) {
        repository.remove(intakeRecord: intakeRecord)
    }
    
    func getCaffeineAmount(record: IntakeRecord) -> Int {
        var caffenine = record.size.caffeineAmount
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
        //  카페인을 모두 배출된 시간을 위해 임의로 정한 값
        let standard = 50.0
        let days = 3
        let halfLifeInSecond: Double = 4 * 60 * 60
        
        if !isRecordExist(days: days) {
            return 0
        }
        
        let remainCaffeine = getRemainCaffeineAmount()
        
        return Int((-log2(standard / Double(remainCaffeine)) * halfLifeInSecond))
    }
    
    private func isRecordExist(days: Int) -> Bool {
        return (getRecentRecords(days: days).count != 0)
    }
    
    func getRemainCaffeineAmount() -> Double {
        //  마시자 마자 잔존량이 줄어드는 것을 방지하기 위해서 생성
        let offset = 0.1
        
        //  3일치 기록을 가져옴, 3일은 임의로 정한 기간, 수정할 수 있음
        let records = getRecentRecords(days: 3)
        
        var amount = 0.0
        for record in records {
            let remainCaffeine = self.calculateRemainCaffeine(date: record.date,
                                                              caffeine: getCaffeineAmount(record: record))
            amount += remainCaffeine
        }
        
        return amount + offset
    }
    
    private func calculateRemainCaffeine(date: Date, caffeine: Int) -> Double {
        let timeInterval = Date.now.timeIntervalSince(date)
        let halfLifeInSecond: Double = 4 * 60 * 60
        
        return Double(caffeine) * pow(1 / 2, timeInterval / halfLifeInSecond)
    }
    
    private func getRecentRecords(days: Int) -> [IntakeRecord] {
        let hoursInDay: Double = 24 * 60 * 60
        var records: [IntakeRecord] = []
        
        for day in 0..<days {
            records += getDailyRecords(date: Date(timeIntervalSinceNow: -hoursInDay * Double(day)))
        }
        return records
    }

}
