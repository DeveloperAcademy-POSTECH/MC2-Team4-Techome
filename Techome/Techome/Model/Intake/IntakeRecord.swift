//
//  IntakeRecord.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct IntakeRecord: Hashable, Codable {
    var uuid = UUID()
    let date: Date
    let beverage: Beverage
    var addedShotCount: Int
}
