//
//  Beverage.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct Beverage: Hashable, Codable {
    var uuid = UUID()
    let name: String
    let franchise: Franchise
    let size: String
    let caffeineAmount: Int
    let defaultShotCount: Int
    var addedShotCount = 0
}
