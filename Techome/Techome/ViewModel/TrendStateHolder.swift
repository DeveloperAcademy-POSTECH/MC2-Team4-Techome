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
    
    let records: [IntakeRecord]
    
    init() {
        records = intakeManager.getAllRecords()
    }
}
