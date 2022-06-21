//
//  CategoryRow.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct CategoryRow: View {
    @EnvironmentObject var stateHolder: CaffenineBookStateHolder
    
    var body: some View {
        HStack(spacing: .zero) {
            ForEach(stateHolder.categories, id: \.self) { category in
                CategoryCell(category: category,
                             isSelected: category == stateHolder.selectedCategory)
                    .onTapGesture {
                        withAnimation(.linear(duration: CaffeineBookAnimationValue.Duration.tabBar.rawValue)) {
                            stateHolder.selectedCategory = category
                        }
                    }
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow()
            .environmentObject(CaffenineBookStateHolder())
            .previewLayout(.sizeThatFits)
    }
}
