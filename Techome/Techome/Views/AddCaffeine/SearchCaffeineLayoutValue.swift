//
//  SearchCaffeineLayoutValue.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/12.
//

import SwiftUI

struct SearchCaffeineViewLayoutValue {
    
    struct Padding {
        static let cardHorizontalPadding: CGFloat = 15
        static let cardVerticalPadding: CGFloat = 28
        static let cardItemHorizontalPadding: CGFloat = 19
        static let cardItemVerticalPadding: CGFloat = 17
        static let cardTitleHorizontalPadding: CGFloat = 6
        static let searchBarClearRight: CGFloat = 4
        static let searchBarClearTotal: CGFloat = 10
        static let searchBarGlassLeft: CGFloat = 12
        
    }
    
    struct Size {
        static let mainWidth: CGFloat = UIScreen.main.bounds.width
        static let mainHeight: CGFloat = UIScreen.main.bounds.height
        static let searchBarMaxWidth: CGFloat = 600
        static let searchBarHeight: CGFloat = 48
    }
    
    struct Radius {
        static let shadow: CGFloat = 2
        static let searchbar: CGFloat = 5
        static let card: CGFloat = 7
    }
}
