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
            return 50
        }
    }
    
    func getSizeAmount(size: String) -> Int {
        switch self {
        case .starbucks:
            switch size {
            case "Tall":
                return 355
                
            case "Grande":
                return 473
                
            case "Venti":
                return 591
                
            default:
                fatalError("No Size")
            }
            
        case .twosomePlace:
            switch size {
            case "Tall":
                return 355
                
            case "Grande":
                return 473
                
            case "Venti":
                return 591
                
            default:
                fatalError("No Size")
            }
        }
    }
}


