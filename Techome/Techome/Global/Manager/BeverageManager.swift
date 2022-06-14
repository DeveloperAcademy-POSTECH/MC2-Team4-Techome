//
//  SearchBeverageManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/11.
//

import Foundation

final class BeverageManager {
    static var shared = BeverageManager()
    private init() {}
    
    private let repository = BeverageRepository()
    
    func getAllBeverages() -> [Beverage] {
        return repository.getAllBeverages()
    }
    
    func getBeverage(name: String, franchise: Franchise) -> [Beverage]? {
        let beverage = repository.getBeverageBySize(name: name, franchise: franchise)
        
        if beverage.isEmpty {
            return nil
        } else {
            return beverage
        }
    }
    
    func getSatisfiedBeveragesByString(searchString: String) -> [Beverage] {
        let searchWords = searchString.components(separatedBy: " ")
        return repository.findBySearchWords(searchWords: searchWords)
    }
}
