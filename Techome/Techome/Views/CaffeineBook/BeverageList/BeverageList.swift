//
//  BeverageList.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct BeverageList: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                RoundedRectangle(cornerRadius: CaffeineBookLayoutValue.Radius.beverageList.rawValue)
                    .foregroundColor(.white)
                
                LazyVStack(spacing: 0) {
                    ForEach(dummyBeverages, id: \.self) { beverage in
                        BeverageListRow(beverage: beverage)
                    }
                }
            }
            .padding(.top, CaffeineBookLayoutValue.Padding.BeverageList.top.rawValue)
            .frame(width: screenWidth - CaffeineBookLayoutValue.Padding.BeverageList.horizontal.rawValue * 2)
        }
        .shadow(color: .primaryShadowGray, radius: CaffeineBookLayoutValue.Radius.shadow.rawValue, x: 0, y: 0)
    }
}


struct BeverageList_Previews: PreviewProvider {
    static var previews: some View {
        BeverageList()
    }
}
