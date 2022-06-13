//
//  Franchise.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

enum Franchise: String, Hashable, Codable {
    case starbucks = "스타벅스"
    case twosomePlace = "투썸플레이스"
    
    func getFranchiseName() -> String {
        return self.rawValue
    }
    
    func getCaffeinPerShot() -> Int {
        switch self {
        case .starbucks:
            return 75
        case .twosomePlace:
            return 88
        }
    }
    
    func getSizeAmount(size: String) -> Int {
        switch self {
        case .starbucks:
            return SizeMap.starbucks[size]!
            
        case .twosomePlace:
            return SizeMap.twosomePlace[size]!
        }
    }
}

struct SizeMap{
    static let starbucks = ["Tall": 355, "Grande": 473, "Venti": 591]
    static let twosomePlace = ["Regular": 355, "Large": 473, "Venti": 591]
}
