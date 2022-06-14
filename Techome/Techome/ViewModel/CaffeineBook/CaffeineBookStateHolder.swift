//
//  CaffeineBookStateHolder.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/14.
//

import Foundation

final class CaffenineBookStateHolder: ObservableObject {
    typealias Index = Int
    
    @Published var selectedCategory: String = categories[0]
    @Published var selectedFranchise: Franchise = Franchise.starbucks
    
    static let categories = ["프렌차이즈", "홈/개인카페", "마트/편의점"]
    static let franchises = Franchise.allCases
}
