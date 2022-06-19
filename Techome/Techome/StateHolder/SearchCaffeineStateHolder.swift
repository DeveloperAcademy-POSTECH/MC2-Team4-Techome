//
//  SearchCaffeineStateHolder.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/13.
//

import Foundation

final class SearchCaffeineStateHolder: ObservableObject {
    @Published var searchText: String = ""
    @Published var oneStepPreviousItems: [Beverage] = []
    @Published var nonEmptyPreviousItems: [Beverage] = []
    @Published var currentItems: [Beverage] = []
    @Published var previousSearchText: String = ""
    
    func searchItems(searchString: String) {
        currentItems = BeverageManager.shared.getSatisfiedBeveragesByString(searchString: searchString)
        if currentItems.isEmpty {
            if searchString == "" {
                currentItems = []
            } else if previousSearchText.count < searchText.count {
                currentItems = []
            }
            else if previousSearchText.count > searchText.count {
                currentItems = nonEmptyPreviousItems
            }
            else {
                currentItems = oneStepPreviousItems
            }
        } else {
            nonEmptyPreviousItems = currentItems
        }
        oneStepPreviousItems = currentItems
        previousSearchText = searchText
    }
}
