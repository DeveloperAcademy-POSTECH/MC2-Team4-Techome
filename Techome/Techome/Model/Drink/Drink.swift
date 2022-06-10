//
//  Drink.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct Drink: Hashable, Codable{
    var name: String
    var franchise: Franchise
    var caffeineAmount: Int
    var addedShotCount: Int
}
