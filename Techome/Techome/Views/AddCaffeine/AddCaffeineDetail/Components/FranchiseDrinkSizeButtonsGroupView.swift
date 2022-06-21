//
//  FranchiseDrinkSizeButtonsGroupView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import SwiftUI

struct SelectedButtonBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
            .stroke(Color.primaryBrown, lineWidth: 1)
            .foregroundColor(.white)
    }
}

struct FranchiseDrinkSizeButtonsGroupView: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            //TODO: 임시 버튼 갯수 로직 구현 필요
            ForEach(addCaffeineDetailStates.beverge.sizeInfo, id: \.self) { sizeInfo in
                FranchiseDrinkSizeButton(sizeInfo: sizeInfo)
            }
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.DrinkSizeButton.horizontal)
        }
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVertical)
    }
}

struct FranchiseDrinkSizeButton: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    let sizeInfo: SizeInfo
    private let buttonBackWidth: CGFloat = 116.65
    private let buttonBackHeight: CGFloat = 43
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
                .stroke(addCaffeineDetailStates.selectedSizeInfo == sizeInfo ? Color.primaryBrown : .clear, lineWidth: 1)
                .foregroundColor(.white)
                .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero)
                .frame(width: buttonBackWidth, height: buttonBackHeight, alignment: .center)
            Text(sizeInfo.name)
                .font(.body)
                .foregroundColor(addCaffeineDetailStates.selectedSizeInfo == sizeInfo ? .primaryBrown : .secondaryTextGray)
        }
        .onTapGesture {
            addCaffeineDetailStates.selectedSizeInfo = sizeInfo
            addCaffeineDetailStates.addedShotCount = 0
        }
    }
}
