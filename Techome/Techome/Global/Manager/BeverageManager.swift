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
        return repository.findAll()
    }
    
    func getBeverage(name: String, franchise: Franchise) -> Beverage? {
        return repository.findByNameAndFranchise(name: name, franchise: franchise)
    }
    
    func getSatisfiedBeveragesByString(searchString: String) -> [Beverage] {
        let searchWords = searchString.components(separatedBy: " ")
        return repository.findBySearchWords(searchWords: searchWords)
    }
    
    func getBeverages(franchise: Franchise) -> [Beverage] {
        return repository.findByFranchise(franchise: franchise)
    }
}
