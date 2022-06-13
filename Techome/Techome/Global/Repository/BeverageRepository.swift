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
    private let jsonManager = JSONManager.shared
    
    init() {
        beverages = jsonManager.load(filename: resourceFileName)
        
        if beverages.isEmpty {
            print("Copy Beverage Data")
            jsonManager.copyBeverageData()
            beverages = jsonManager.load(filename: resourceFileName)
            
            //  데이터 구조가 변경되었을 때 json 파일을 만들기 위한 로직
            //  JSONManager.shared.store(data: dummyBeverages, filename: "BeverageData.json")
        }
    }
    
    func findByNameAndFranchise(name: String, franchise: Franchise) -> Beverage? {
        for beverage in beverages {
            if beverage.name == name && beverage.franchise == franchise {
                return beverage
            }
        }
        
        return nil
    }
    
    func findAll() -> [Beverage] {
        return beverages
    }
}
