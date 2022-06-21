//
//  CategoryCell.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct CategoryCell: View {
    let category: Category
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(category.rawValue)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(isSelected
                                 ? .customBlack
                                 : .secondaryTextGray)
                .frame(width: screenWidth / 3,
                       height: CaffeineBookLayoutValue.Size.TopBar.Category.height.rawValue,
                       alignment: .center)
                .padding(.horizontal, CaffeineBookLayoutValue.Padding.TopBar.Category.horizontal.rawValue)
                .padding(.top, CaffeineBookLayoutValue.Padding.TopBar.Category.top.rawValue)
                .padding(.bottom, CaffeineBookLayoutValue.Padding.TopBar.Category.bottom.rawValue)
            
            Rectangle()
                .frame(height: CaffeineBookLayoutValue.Size.TopBar.Line.height.rawValue)
                .foregroundColor(isSelected
                                 ? .primaryBrown
                                 : .white)
        }
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryCell(category: Category.franchise, isSelected: true)
            CategoryCell(category: Category.franchise, isSelected: false)
        }
        .frame(width: screenWidth / 3)
        .previewLayout(.sizeThatFits)
    }
}
