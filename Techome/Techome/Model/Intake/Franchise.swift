//
//  Franchise.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

enum Franchise: String, CaseIterable, Hashable, Codable {
    case starbucks = "스타벅스"
    case twosomePlace = "투썸플레이스"
//    case coffeeBean = "커피빈"
    case ediyaCoffee = "이디아커피"
    
    func getFranchiseName() -> String {
        return self.rawValue
    }
    
    func getCaffeinPerShot() -> Int {
        switch self {
        case .starbucks:
            return 75
        case .twosomePlace:
            return 88
//        case .coffeeBean:
//            return 99
        case .ediyaCoffee:
            return 91
        }
    }
    
    func getSizeAmount(size: String) -> Int {
        switch self {
        case .starbucks:
            return SizeMap.starbucks[size]!
            
        case .twosomePlace:
            return SizeMap.twosomePlace[size]!
            
//        case .coffeeBean:
//            return SizeMap.coffeeBean[size]!
            
        case .ediyaCoffee:
            return SizeMap.ediyaCoffee[size]!
        }
    }
}

struct SizeMap {
    static let starbucks = ["Tall": 355, "Grande": 473, "Venti": 591]
    static let twosomePlace = ["Regular": 355, "Large": 473]
//    static let coffeeBean = ["Small": 355, "Medium": 473, "Large": 591]
    static let ediyaCoffee = ["Regular": 384, "Extra": 651]
}
