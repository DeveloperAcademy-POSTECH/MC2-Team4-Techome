//
//  CaffeineBookDetailStateHolder.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import Foundation

final class CaffeineBookDetailStateHolder: ObservableObject {
    
    @Published var Beverage: Beverage = dummyBeverages[0]
    @Published var isSelected: Int = 0

}
