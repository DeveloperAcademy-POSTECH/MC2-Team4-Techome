//
//  SearchCaffeineStateHolder.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/13.
//

import Foundation

final class SearchCaffeineStateHolder: ObservableObject {
    @Published var searchText: String = ""
    
    
    init() {
        self.searchText = searchText
    }
    
    func onChangeString(searchString: String) -> [Beverage] {
        let result = BeverageManager.shared.getSatisfiedBeveragesByString(searchString: searchString)
        print(result)
        return result
    }
}
