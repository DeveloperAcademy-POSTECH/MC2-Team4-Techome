//
//  CaffeineBookStateHolder.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/14.
//

import Foundation

final class CaffenineBookStateHolder: ObservableObject {
    @Published var selectedCategory: Category = Category.franchise
    @Published var selectedFranchise: Franchise = Franchise.starbucks
    
    let categories = Category.allCases
    let franchises = Franchise.allCases
}

enum Category: String, CaseIterable {
    case franchise = "프렌차이즈"
    case personal = "홈/개인카페"
    case mart = "마트/편의점"
}
