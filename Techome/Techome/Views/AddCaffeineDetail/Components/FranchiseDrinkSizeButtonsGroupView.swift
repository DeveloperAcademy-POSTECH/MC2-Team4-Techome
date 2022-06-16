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
            ForEach(0 ..< addCaffeineDetailStates.bevergeRecord.sizeInfo.count) { drinkSizeButtonIndex in
                FranchiseDrinkSizeButton(size: addCaffeineDetailStates.bevergeRecord.sizeInfo[drinkSizeButtonIndex].name, buttonIndex: drinkSizeButtonIndex)
            }
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.DrinkSizeButton.horizontal)
        }
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVertical)
    }
}

struct FranchiseDrinkSizeButton: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    fileprivate var size: String
    fileprivate var buttonIndex: Int
    private let buttonBackWidth: CGFloat = 116.65
    private let buttonBackHeight: CGFloat = 43
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
                .stroke(addCaffeineDetailStates.isSelected == buttonIndex ? Color.primaryBrown : .clear, lineWidth: 1)
                .foregroundColor(.white)
                .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero)
                .frame(width: buttonBackWidth, height: buttonBackHeight, alignment: .center)
            Text(size)
                .font(.body)
                .foregroundColor(addCaffeineDetailStates.isSelected == buttonIndex ? .primaryBrown : .secondaryTextGray)
        }
        .onTapGesture {
            addCaffeineDetailStates.isSelected = buttonIndex
            addCaffeineDetailStates.shotCount = addCaffeineDetailStates.getDefaultShot()
            addCaffeineDetailStates.addCaffeineAmount = addCaffeineDetailStates.getWillAddCaffeineAmount()
        }
    }
}
