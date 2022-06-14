//
//  IntakeRecord.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct IntakeRecord: Identifiable, Hashable, Codable {
    var id = UUID()
    let date: Date
    let beverage: Beverage
    let size: SizeInfo
    var addedShotCount: Int
}
