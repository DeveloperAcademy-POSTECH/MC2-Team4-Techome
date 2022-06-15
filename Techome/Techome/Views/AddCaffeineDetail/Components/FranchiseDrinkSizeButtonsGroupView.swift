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
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            //TODO: 임시 버튼 갯수 로직 구현 필요
            ForEach(0..<3) { drinkSizeButtonIndex in
                FranchiseDrinkSizeButton()
                    
            }
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.DrinkSizeButton.horizontal)
        }
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVertical)
    }
}

struct FranchiseDrinkSizeButton: View {
    var body: some View {
        Button {
            
        } label: {
            //TODO: 음료 크기 임시 더미데이터
            Text("Tall")
                .font(.body)
                .foregroundColor(.secondaryTextGray)
                .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.DrinkSizeButton.insideVertical)
                .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.DrinkSizeButton.insideHorizontal)
                .background(RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
                    .foregroundColor(.white)
                    .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero))
        }
    }
}
