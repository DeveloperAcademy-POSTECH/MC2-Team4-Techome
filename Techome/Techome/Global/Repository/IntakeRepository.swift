//
//  IntakeRecordRepository.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/11.
//

import Foundation

final class IntakeRepository {
    private var records: [IntakeRecord] = []
    private let resourceFileName = "IntakeRecord.json"
    
    init() {
        records = JSONManager.shared.load(filename: resourceFileName)
    }
    
    func addRecord(record: IntakeRecord) {
        records.append(record)
        JSONManager.shared.store(data: records, filename: resourceFileName)
    }
    
    func getDailyRecords(date: Date) -> [IntakeRecord] {
        return records.filter({
            Formatter.date.string(from: $0.date) == Formatter.date.string(from: date)
        })
    }
    
    func getAllRecords() -> [IntakeRecord] {
        return records
    }
    
    func deleteRecord(intakeRecord: IntakeRecord) {
        let removeRecordIndex = records.firstIndex(of: intakeRecord)
        
        guard let index = removeRecordIndex else {
            return
        }
        
        records.remove(at: index)
    }
}
