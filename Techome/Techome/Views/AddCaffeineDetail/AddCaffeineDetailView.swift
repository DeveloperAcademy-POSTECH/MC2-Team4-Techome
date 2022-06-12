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
        static let drinkSizeButtonHorizontalPadding: CGFloat = 2.5
        static let drinkSizeButtonInsideHorizontalPadding: CGFloat = 44
        static let drinkSizeButtonInsideVerticalPadding: CGFloat = 13.5
        static let effectCardVerticalPadding: CGFloat = 15
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
            FranchiseDrinkSizeButtonsGroup()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.sectionPadding)
            Group {
                EffectSectionAddCaffeineAmout()
                    
                HowLongCaffeineStay()
            }
            .background(EffectSectionBackground())
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVerticalPadding)
            .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardVerticalPadding)
            Spacer()
            AddCaffeineButton()
        }
    }
}

struct FranchiseDrinkSizeButtonsGroup: View {
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            //TODO: 임시 버튼 갯수 로직 구현 필요
            ForEach(0..<3) { drinkSizeButtonIndex in
                FranchiseDrinkSizeButton()
                    .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.drinkSizeButtonHorizontalPadding)
            }
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
                .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.drinkSizeButtonInsideVerticalPadding)
                .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.drinkSizeButtonInsideHorizontalPadding)
                .background(RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
                    .foregroundColor(.white)
                    .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero))
        }
    }
}

struct EffectSectionTextModifier {
    struct HeadlineModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.subheadline)
                .foregroundColor(.primaryBrown)
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)

        }
    }
}

extension View {
    func headlineModifier() -> some View {
        modifier(EffectSectionTextModifier.HeadlineModifier())
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
            .headlineModifier()
                        
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
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                Image(systemName: "timer")
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.effectSectionIconToTextPadding)
                //TODO: 임시 더미데이터 변경 필요
                Text("카페인 배출에 2시간 45분이 더 소요됩니다.")
                    .fontWeight(.semibold)
            }
            .headlineModifier()
            Divider()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)
            HStack(alignment: .center, spacing: .zero) {
                Text("예상 배출 완료 시간")
                    .font(.subheadline)
                    .foregroundColor(.secondaryTextGray)
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text("오후")
                        .font(.footnote)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.AddCaffeineAmountToUnitPadding)
                    Text("5")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryBrown)
                    Text("시")
                        .font(.footnote)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.AddCaffeineAmountToUnitPadding)
                    Text("33")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryBrown)
                    Text("분")
                        .font(.footnote)
                        .foregroundColor(.secondaryTextGray)
                }
            }
        }
        .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideVerticalPadding)
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.effectCardInsideHorizontalPadding)
    }
}

struct EffectSectionBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
            .foregroundColor(.white)
            .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero)
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

struct EspressoShotCountStepper: View {
    //TODO: 에스프레소 샷 수 스텝퍼 구조체 구현 전
    var body: some View {
        Text("에스프레소 샷 수 버튼")
    }
}

struct AddCaffeineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCaffeineDetailView()
    }
}
