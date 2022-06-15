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
    private let jsonManager = JSONManager.shared
    private let formatter = Formatter.date
    
    init() {
        records = jsonManager.load(filename: resourceFileName)
    }
    
    func save(date: Date, sideEffects: [SideEffect]) {
        records.append(SideEffectRecord(date: date, sideEffects: sideEffects))
        jsonManager.store(data: records, filename: resourceFileName)
    }
    
    func findByDate(date: Date) -> [SideEffectRecord] {
        let dateString = formatter.string(from: date)
        
        return records.filter({
            formatter.string(from: $0.date) == dateString
        })
    }
    
    func findAll() -> [SideEffectRecord] {
        return records
    }
    
    func remove(sideEffectRecord: SideEffectRecord) {
        let removeRecordIndex = records.firstIndex(of: sideEffectRecord)
        
        guard let index = removeRecordIndex else {
            return
        }
        
        records.remove(at: index)
        jsonManager.store(data: records, filename: resourceFileName)
    }
}
