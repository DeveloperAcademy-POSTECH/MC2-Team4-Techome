//
//  BeverageRepository.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/11.
//

import Foundation

final class BeverageRepository {
    private var starbucksBeverages: [Beverage] = []
    private var twosomePlaceBeverages: [Beverage] = []
    private let resourceStarbucksFileName = "StarbucksData.json"
    private let resourceTwosomePlaceFileName = "TwosomePlaceData.json"
    private let jsonManager = JSONManager.shared
    
    init() {
        starbucksBeverages = jsonManager.load(filename: resourceStarbucksFileName)
        twosomePlaceBeverages = jsonManager.load(filename: resourceTwosomePlaceFileName)
        
        if starbucksBeverages.isEmpty {
            print("Copy Beverage Data")
            jsonManager.copyBeverageData(franchise: "Starbucks")
            starbucksBeverages = jsonManager.load(filename: resourceStarbucksFileName)
            
            //  데이터 구조가 변경되었을 때 json 파일을 만들기 위한 로직
            //  JSONManager.shared.store(data: dummyBeverages, filename: "BeverageData.json")
        }
        
        if twosomePlaceBeverages.isEmpty {
            print("Copy Beverage Data")
            jsonManager.copyBeverageData(franchise: "TwosomePlace")
            starbucksBeverages = jsonManager.load(filename: resourceStarbucksFileName)
        }
    }
    
    func findByNameAndFranchise(name: String, franchise: Franchise) -> Beverage? {
        for beverage in starbucksBeverages {
            if beverage.name == name && beverage.franchise == franchise {
                return beverage
            }
        }
        
        return nil
    }
    
    func findAll() -> [Beverage] {
        return starbucksBeverages
    }
    
    func findBySearchWords(searchWords: [String]) -> [Beverage] {
        var results = starbucksBeverages
        for word in searchWords {
            results = results.filter({
                isContainingWord(beverage: $0, word: word)
            })
        }
        return results
    }
    
    private func isContainingWord(beverage: Beverage, word: String) -> Bool {
        return beverage.name.contains(word) || beverage.franchise.getFranchiseName().contains(word)
    }
    
    func findByFranchise(franchise: Franchise) -> [Beverage] {
        return starbucksBeverages.filter{ $0.franchise == franchise }
    }
}
