//
//  SideEffectRecordManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/10.
//

import Foundation

var sideEffectRecords: [SideEffectRecord] = []

final class SideEffectRecordManager {
    static let shared = SideEffectRecordManager()
    private init() {}
    
    //  부작용 기록 저장
    func addRecord(date: Date, sideEffect: [SideEffect]) {
        sideEffectRecords.append(SideEffectRecord(date: date,
                                                  sideEffect: sideEffect))
        
        do {
            try JSONManager.shared.store(data: sideEffectRecords, filename: "SideEffectRecord.json")
        } catch {
            fatalError("Side Effect Record Save Error")
        }
    }
    
    //  해당 날짜의 부작용 기록 반환
    func getDailyRecords(date: Date) -> [SideEffectRecord] {
        var dailyRecord: [SideEffectRecord] = []

        for record in sideEffectRecords {
            if Formatter.date.string(from: record.date) == Formatter.date.string(from: date) {
                dailyRecord.append(record)
            }
        }

        return dailyRecord
    }
    
    func deleteRecord(sideEffectRecord: SideEffectRecord) {
        let removeRecordIndex = sideEffectRecords.firstIndex(of: sideEffectRecord)
        
        guard let index = removeRecordIndex else {
            return
        }
        
        sideEffectRecords.remove(at: index)
    }
}
