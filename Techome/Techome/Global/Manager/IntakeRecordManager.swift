//
//  IntakeRecordManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/10.
//

import Foundation

typealias SizeIndex = Int

var beverageRecords: [BeverageRecord] = []

final class IntakeRecordManager {
    static let shared = IntakeRecordManager()
    private init() {}
    
    func addRecord(beverage: Beverage, sizeIndex: SizeIndex) {
        beverageRecords.append(BeverageRecord(date: Date.now, beverage: beverage))
        
        do {
            try JSONManager.shared.store(data: beverageRecords, filename: "BeverageRecord.json")
        } catch {
            fatalError("Beverage Record Save Error")
        }
    }
    
    func getDailyRecords(date: Date) -> [BeverageRecord] {
        var dailyBeverageRecords: [BeverageRecord] = []

        for record in beverageRecords {
            if Formatter.date.string(from: record.date) == Formatter.date.string(from: date) {
                dailyBeverageRecords.append(record)
            }
        }

        return dailyBeverageRecords
    }
    
    func deleteRecord(beverageRecord: BeverageRecord) {
        let removeRecordIndex = beverageRecords.firstIndex(of: beverageRecord)
        
        guard let index = removeRecordIndex else {
            return
        }
        
        beverageRecords.remove(at: index)
    }
}
