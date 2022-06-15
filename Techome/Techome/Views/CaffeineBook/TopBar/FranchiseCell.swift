//
//  FranchiseCell.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct FranchiseCell: View {
    let franchise: Franchise
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(franchise.getFranchiseName())
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(isSelected
                                 ? .customBlack
                                 : .secondaryTextGray)
                .frame(height: CaffeineBookLayoutValue.Size.TopBar.Franchise.height.rawValue, alignment: .center)
                .padding(.top, CaffeineBookLayoutValue.Padding.TopBar.Franchise.top.rawValue)
                .padding(.bottom, CaffeineBookLayoutValue.Padding.TopBar.Franchise.bottom.rawValue)
                .padding(.horizontal, CaffeineBookLayoutValue.Padding.TopBar.Franchise.horizontal.rawValue)
            
            Rectangle()
                .frame(height: CaffeineBookLayoutValue.Size.TopBar.Line.height.rawValue)
                .foregroundColor(isSelected
                                 ? .primaryBrown
                                 : .white)
        }
    }
}

struct FranchiseCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FranchiseCell(franchise: Franchise.starbucks, isSelected: true)
            FranchiseCell(franchise: Franchise.starbucks, isSelected: true)
        }
        .frame(width: screenWidth / 3)
        .previewLayout(.sizeThatFits)
    }
}
