//
//  Beverage.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct Beverage: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let franchise: Franchise
    let sizeInfo: [SizeInfo]
}

struct SizeInfo: Hashable, Codable {
    let name: String
    let caffeineAmount: Int
    let defaultShotCount: Int
}
