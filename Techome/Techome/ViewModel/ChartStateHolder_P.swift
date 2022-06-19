//
//  ChartStateHolder_P.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import Foundation

class ChartStateHolder: ObservableObject {
    let intakeManager = IntakeManager.shared
    let sideEffectManager = SideEffectManager.shared
    var dateArray: [Date] = []
    @Published var isShowRecord = false
    @Published var selectedDayIntakeRecord: [IntakeRecord] = []
    @Published var selectedDaySideEffectRecord: [SideEffect] = []
    private let day = 24 * 60 * 60
    
//    func makeDateArray() {
    init() {
        var chartStartDate = getFirstChartDay()
        
        while chartStartDate < Date() {
            dateArray.append(chartStartDate)
            chartStartDate = chartStartDate.addingTimeInterval(TimeInterval(day * 7))
        }
    }
    
    func showRecord(date: Date) {
        selectedDayIntakeRecord = intakeManager.getDailyRecords(date: date)
        selectedDaySideEffectRecord = sideEffectManager.getDailyRecords(date: date)
        isShowRecord = true
    }
    
    func disableList() {
        isShowRecord = false
    }
    
    func getWeeklyCaffeineAmount(date: Date) -> [Int] {
        var amountArray: [Int] = []
        for d in 0..<7 {
            amountArray.append(Int(intakeManager.getDailyIntakeCaffeineAmount(date: date.addingTimeInterval(TimeInterval(day * d)))))
        }
        
        return amountArray
    }
    
    func getMaxAmountInWeek(date: Date) -> Int {
        var amount = 0
        for d in 0..<7 {
            let caffeineAmount = Int(intakeManager.getDailyIntakeCaffeineAmount(date: date.addingTimeInterval(TimeInterval(day * d))))
            
            amount = amount < caffeineAmount ? caffeineAmount : amount
        }
        
        return amount
    }
    
    func getDailyRecord(date: Date) -> ([IntakeRecord], [SideEffect]) {
        return (intakeManager.getDailyRecords(date: date), sideEffectManager.getDailyRecords(date: date))
    }
    
    func getFirstChartDay() -> Date {
        return getSundayOfWeek(date: intakeManager.getFirstRecordDate() ?? Date())
    }
    
    private func getSundayOfWeek(date: Date) -> Date {
        return date.addingTimeInterval(Double(day * -getWeekDay(date: date)))
    }
    
    private func getWeekDay(date: Date) -> Int {
        return Calendar(identifier: .gregorian).dateComponents([.weekday], from: date).weekday! - 1
    }
    
    func getWeeklyAverageCaffeineAmount(date: Date) -> Int {
        var intakeDateCount = 0
        var amount = 0
        
        for d in 0..<7 {
            let records = intakeManager.getDailyRecords(date: date.addingTimeInterval(TimeInterval(d * day)))
            
            if !records.isEmpty {
                intakeDateCount += 1
                for record in records {
                    amount += intakeManager.getCaffeineAmount(record: record)
                }
            }
        }
        
        if intakeDateCount == 0 {
            return 0
        }
        
        return Int(amount / intakeDateCount)
    }
}
