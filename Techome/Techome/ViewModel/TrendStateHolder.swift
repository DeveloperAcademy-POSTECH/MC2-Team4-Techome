//
//  TrendStateHolder.swift
//  Techome
//
//  Created by 한택환 on 2022/06/16.
//

import Foundation

class TrendStateHolder: ObservableObject {
    let intakeManager: IntakeManager = IntakeManager.shared
    let sideEffectManager: SideEffectManager = SideEffectManager.shared
    let intakeRecords: [IntakeRecord]
    @Published var ChartWeekIndex: Int = 0
    
    init() {
        intakeRecords = intakeManager.getDailyRecords(date: Date.now)
    }
}
