//
//  SideEffectRecordRepository.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/11.
//

import Foundation

final class SideEffectRepository {
    private var records: [SideEffectRecord] = []
    private let resourceFileName = "SideEffectRecord.json"
    
    init() {
        records = JSONManager.shared.load(filename: resourceFileName)
    }
    
    func addRecord(date: Date, sideEffects: [SideEffect]) {
        records.append(SideEffectRecord(date: date, sideEffects: sideEffects))
        JSONManager.shared.store(data: records, filename: resourceFileName)
    }
    
    func getDailyRecords(date: Date) -> [SideEffectRecord] {
        return records.filter({
            Formatter.date.string(from: $0.date) == Formatter.date.string(from: date)
        })
    }
    
    func getAllRecords() -> [SideEffectRecord] {
        return records
    }
    
    func deleteRecord(sideEffectRecord: SideEffectRecord) {
        let removeRecordIndex = records.firstIndex(of: sideEffectRecord)
        
        guard let index = removeRecordIndex else {
            return
        }
        
        records.remove(at: index)
    }
}
