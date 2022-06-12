//
//  SideEffectRecordManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/10.
//

import Foundation

final class SideEffectManager {
    static let shared = SideEffectManager()
    private init() {}
    
    let repository = SideEffectRepository()
    
    func addRecord(date: Date, sideEffects: [SideEffect]) {
        repository.addRecord(date: date, sideEffects: sideEffects)
    }
    
    func getDailyRecords(date: Date) -> [SideEffect] {
        let dailyRecords = repository.getDailyRecords(date: date)
        var dailySideEffects: Set<SideEffect> = []
        
        for record in dailyRecords {
            dailySideEffects = dailySideEffects.union(record.sideEffects)
        }

        return Array(dailySideEffects).sorted(by: { $0.rawValue < $1.rawValue })
    }
    
    func getAllRecords() -> [SideEffectRecord] {
        return repository.getAllRecords()
    }
    
    func deleteRecord(sideEffectRecord: SideEffectRecord) {
        repository.deleteRecord(sideEffectRecord: sideEffectRecord)
    }
}
