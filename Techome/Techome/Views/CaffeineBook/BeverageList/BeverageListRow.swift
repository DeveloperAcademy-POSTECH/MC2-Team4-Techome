//
//  BeverageListRow.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct BeverageListRow: View {
    let beverage: Beverage
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: {
//                CaffeineBookDetailView(beverage: beverage)
            }) {
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text(beverage.name)
                            .font(.system(size: 19, weight: .regular))
                            .foregroundColor(.customBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, CaffeineBookLayoutValue.Padding.BeverageList.innerHorizontal.rawValue)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(beverage.sizeInfo[0].name + " 기준")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryTextGray)
                                .padding(.horizontal, CaffeineBookLayoutValue.Padding.BeverageList.textBetweenSizeAndAmount.rawValue)
                            
                            Text(String(beverage.sizeInfo[0].caffeineAmount))
                                .font(.system(size: 19, weight: .regular))
                                .foregroundColor(.customBlack)
                                .frame(width: CaffeineBookLayoutValue.Size.BeverageList.caffeineAmountWidth.rawValue, alignment: .trailing)
                                .padding(.trailing, CaffeineBookLayoutValue.Padding.BeverageList.textBetweenAmountAndUnit.rawValue)
                            
                            Text("mg")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryTextGray)
                                .padding(.trailing, CaffeineBookLayoutValue.Padding.BeverageList.innerHorizontal.rawValue)
                        }
                    }
                    .frame(height: CaffeineBookLayoutValue.Size.BeverageList.height.rawValue)
                    
                    Divider()
                }
            }
        }
    }
}

struct BeverageListRow_Previews: PreviewProvider {
    static var previews: some View {
        BeverageListRow(beverage: dummyBeverages[0])
            .previewLayout(.sizeThatFits)
    }
}
