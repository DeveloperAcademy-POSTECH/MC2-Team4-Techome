//
//  BeverageList.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct BeverageList: View {
    @EnvironmentObject var stateHolder: CaffenineBookStateHolder
    let manager = BeverageManager.shared
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                RoundedRectangle(cornerRadius: CaffeineBookLayoutValue.Radius.beverageList.rawValue)
                    .foregroundColor(.white)
                
                LazyVStack(spacing: .zero) {
                    switch stateHolder.selectedCategory {
                    case .franchise:
                        let beverages = manager.getBeverages(franchise: stateHolder.selectedFranchise)
                        
                        if beverages.count == 0 {
                            EmptyListView()
                        } else {
                            ForEach(beverages, id: \.self) { beverage in
                                BeverageListRow(beverage: beverage)
                            }
                        }
                        
                    case .personal:
                        EmptyListView()
                        
                    case .mart:
                        EmptyListView()
                    }
                }
            }
            .padding(.top, CaffeineBookLayoutValue.Padding.BeverageList.top.rawValue)
            .padding(.horizontal, CaffeineBookLayoutValue.Padding.BeverageList.horizontal.rawValue)
            .shadow(color: .primaryShadowGray, radius: CaffeineBookLayoutValue.Radius.shadow.rawValue, x: 0, y: 0)
        }
        
    }
}


struct BeverageList_Previews: PreviewProvider {
    static var previews: some View {
        BeverageList()
            .previewLayout(.sizeThatFits)
    }
}
