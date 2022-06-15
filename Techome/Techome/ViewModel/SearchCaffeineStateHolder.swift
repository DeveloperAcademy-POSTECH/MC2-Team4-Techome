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
    @Published var twoStepPreviousItems: [Beverage] = []
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
                currentItems = twoStepPreviousItems
            }
            else {
                currentItems = oneStepPreviousItems
            }
        } else {
            twoStepPreviousItems = currentItems
        }
        oneStepPreviousItems = currentItems
        previousSearchText = searchText
    }
}
