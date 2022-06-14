//
//  BeverageRepository.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/11.
//

import Foundation

final class BeverageRepository {
    private var beverages: [Beverage] = []
    private let resourceFileName = "BeverageData.json"
    
    init() {
        beverages = JSONManager.shared.load(filename: resourceFileName)
        
        if beverages.isEmpty {
            print("Copy Beverage Data")
            JSONManager.shared.copyBeverageData()
            beverages = JSONManager.shared.load(filename: resourceFileName)
        }
    }
    
    func getBeverageBySize(name: String, franchise: Franchise) -> [Beverage] {
        return beverages.filter({
            $0.name == name && $0.franchise == franchise
        })
    }
    
    func getAllBeverages() -> [Beverage] {
        return beverages
    }
    
    func findBySearchWords(searchWords: [String]) -> [Beverage] {
        var results = beverages
        for word in searchWords {
            results = results.filter({
                isContainingWord(beverage: $0, word: word)
            })
        }
        return results
    }
    
    func isContainingWord(beverage: Beverage, word: String) -> Bool {
        return beverage.name.contains(word) || beverage.franchise.getFranchiseName().contains(word)
    }
}
