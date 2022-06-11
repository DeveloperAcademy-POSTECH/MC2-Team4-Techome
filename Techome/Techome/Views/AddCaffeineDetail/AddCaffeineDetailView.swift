//
//  AddCaffeineDetailView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/11.
//

import SwiftUI

struct AddCaffeineDetailViewLayoutValue {
    
    struct Paddings {
        static let sectionPadding: CGFloat = 42
        static let sectionTitleToComponentPadding: CGFloat = 15
        static let cardVerticalPadding: CGFloat = 15
        static let franchiseDrinkSizeButtonHorizontalPadding: CGFloat = 2.5
        static let franchiseDrinkSizeButtonInsideHorizontalPadding: CGFloat = 44
        static let franchiseDrinkSizeButtonInsideVerticalPadding: CGFloat = 13.5
        static let effectCardInsideHorizontalPadding: CGFloat = 18
        static let effectCardInsideVerticalPadding: CGFloat = 14
        static let effectDividerHorizontalPadding: CGFloat = 10
        static let effectSectionIconToTextPadding: CGFloat = 6
        static let AddCaffeineAmountToUnitPadding: CGFloat = 3
    }
    
    struct Sizes {
        static let addCaffeineButtonHeight: CGFloat = 60
    }
    
    struct CornerRadius {
        static let cardRadius: CGFloat = 5
        static let shadowRadius: CGFloat = 2
    }
}

struct AddCaffeineDetailView: View {
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            FranchiseDrinkSizeButtonGroup()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.sectionPadding)
            Group {
                EffectSectionAddCaffeineAmout()
                    .background(EffectSectionBackground())
            }
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVerticalPadding)
            .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.sectionPadding)
            Spacer()
            AddCaffeineButton()
        }
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
                .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.franchiseDrinkSizeButtonInsideVerticalPadding)
                .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.franchiseDrinkSizeButtonInsideHorizontalPadding)
                .background(RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
                    .foregroundColor(.white)
                    .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero))
            
        }
    }
}


struct FranchiseDrinkSizeButtonGroup: View {
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            //TODO: 임시 버튼 갯수 로직 구현 필요
            ForEach(0..<3) { franchiseDrinkSizeButtonIndex in
                FranchiseDrinkSizeButton()
                    .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.franchiseDrinkSizeButtonHorizontalPadding)
            }
            
        }
    }
}

struct EffectSectionAddCaffeineAmout: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                Image(systemName: "circle.hexagongrid")
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.effectSectionIconToTextPadding)
                //TODO: 임시 더미데이터 변경 필요
                Text("추가되는 카페인은 150mg 입니다.")
                    .fontWeight(.semibold)
            }
            .font(.subheadline)
            .foregroundColor(.primaryBrown)
            .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)
            
            Divider()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)
            CurrentCaffeineAmount()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)
            AfterCaffeineAmount()
        }
        .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideHorizontalPadding)
    }
}

struct CurrentCaffeineAmount: View {
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Text("현재")
                .font(.subheadline)
                .foregroundColor(.secondaryTextGray)
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                //TODO: 임시 더미데이터 변경 필요
                Text("130")
                    .font(.title2)
                    .fontWeight(.semibold)
                //TODO: customBlack으로 변경 필요
                    .foregroundColor(.black)
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.AddCaffeineAmountToUnitPadding)
                Text("mg")
                    .font(.footnote)
                    .foregroundColor(.secondaryTextGray)
            }
        }
    }
}

struct AfterCaffeineAmount: View {
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Text("섭취 후")
                .font(.subheadline)
                .foregroundColor(.secondaryTextGray)
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                //TODO: 임시 더미데이터 변경 필요
                Text("280")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryBrown)
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.AddCaffeineAmountToUnitPadding)
                Text("mg")
                    .font(.footnote)
                    .foregroundColor(.secondaryTextGray)
            }
        }
    }
}

struct HowLongCaffeineStay: View {
    var body: some View {
        Text("카페인 배출 소요시간")
    }
}

struct AddCaffeineButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("추가하기")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.backgroundCream)
                .background(AddCaffeineButtonBackground())
        }
        
        
    }
}

struct AddCaffeineButtonBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
            .foregroundColor(.primaryBrown)
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVerticalPadding)
            .frame(width: UIScreen.main.bounds.width, height: AddCaffeineDetailViewLayoutValue.Sizes.addCaffeineButtonHeight, alignment: .center)
    }
}

struct EspressoShotCountButton: View {
    var body: some View {
        Text("에스프레소 샷 수 버튼")
    }
}

struct EffectSectionBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
            .foregroundColor(.white)
            .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero)
    }
}

struct AddCaffeineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCaffeineDetailView()
    }
}
