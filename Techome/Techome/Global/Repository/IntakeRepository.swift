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
    private let jsonManager = JSONManager.shared
    private let formatter = Formatter.date
    
    init() {
        records = jsonManager.load(filename: resourceFileName)
    }
    
    func save(record: IntakeRecord) {
        records.append(record)
        jsonManager.store(data: records, filename: resourceFileName)
    }
    
    func findByDate(date: Date) -> [IntakeRecord] {
        let dateString = formatter.string(from: date)
        
        return records.filter({
            formatter.string(from: $0.date) == dateString
        })
    }
    
    func findRecent(count: Int) -> [IntakeRecord] {
        return records.suffix(count).reversed()
    }
    
    func findAll() -> [IntakeRecord] {
        return records
    }
    
    func remove(intakeRecord: IntakeRecord) {
        let removeRecordIndex = records.firstIndex(of: intakeRecord)
        
        guard let index = removeRecordIndex else {
            return
        }
        
        records.remove(at: index)
        jsonManager.store(data: records, filename: resourceFileName)
    }
}
