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
        static let navigationBarToTitlePadding: CGFloat = 34
        static let sectionTitleToComponentPadding: CGFloat = 15
        static let cardVerticalPadding: CGFloat = 15
        static let titleToBrandPadding: CGFloat = 5
        static let drinkSizeButtonHorizontalPadding: CGFloat = 2.5
        static let drinkSizeButtonInsideHorizontalPadding: CGFloat = 44
        static let drinkSizeButtonInsideVerticalPadding: CGFloat = 13.5
        static let effectCardVerticalPadding: CGFloat = 15
        static let effectCardInsideHorizontalPadding: CGFloat = 18
        static let effectCardInsideVerticalPadding: CGFloat = 14
        static let effectDividerHorizontalPadding: CGFloat = 10
        static let effectSectionIconToTextPadding: CGFloat = 6
        static let AddCaffeineAmountToUnitPadding: CGFloat = 3
        static let stepperInsideVerticalPadding: CGFloat = 14
        static let stepperInsideHorizontalPadding: CGFloat = 49
    }
    
    struct Sizes {
        static let addCaffeineButtonHeight: CGFloat = 60
        
        static let stepperStepFixedWidth: CGFloat = 17
        static let stepperStepFixedHeight: CGFloat = 15
        static let stepperValueFixedWidth: CGFloat = 20
        static let stepperValueFixedHeight: CGFloat = 15
    }
    
    struct CornerRadius {
        static let cardRadius: CGFloat = 5
        static let shadowRadius: CGFloat = 2
    }
}

struct AddCaffeineDetailView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: .zero) {
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text("아메리카노")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, AddCaffeineDetailViewLayoutValue.Paddings.cardVerticalPadding)
                    Text("스타벅스")
                        .font(.title3)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.leading, AddCaffeineDetailViewLayoutValue.Paddings.titleToBrandPadding)
                    Spacer()
                }
                .padding(.top, AddCaffeineDetailViewLayoutValue.Paddings.navigationBarToTitlePadding)
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.sectionPadding)
                
                FranchiseDrinkSizeButtonsGroup()
                    .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.sectionPadding)
                
                EspressoShotCountStepper()
                    .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.sectionPadding)
                Group {
                    EffectSectionAddCaffeineAmountProvider()
                    
                    CaffeineResidualTimeProvider()
                }
                .background(EffectSectionBackground())
                .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVerticalPadding)
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.effectCardVerticalPadding)
                Spacer()
                AddCaffeineButton()
            }
            .navigationTitle("카페인 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Image(systemName: "chevron.left")
                .font(.headline)
                .foregroundColor(.primaryBrown), trailing: Text("취소")
                .font(.body)
                .foregroundColor(.primaryBrown))
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

struct SelectedButtonBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
            .stroke(Color.primaryBrown, lineWidth: 1)
            .foregroundColor(.white)
            
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

struct EffectSectionAddCaffeineAmountProvider: View {
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

struct CaffeineResidualTimeProvider: View {
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

//https://serialcoder.dev/text-tutorials/swiftui/rounding-specific-corners-in-swiftui-views/
struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct EspressoShotCountStepper: View {
    //TODO: 임시 더미 데이터
    @State var shotCount: Int = 2
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Button {
                if shotCount > 0 {
                    shotCount -= 1
                }
            } label: {
                Image(systemName: "minus")
                    .frame(width: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedWidth, height: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedHeight, alignment: .center)
                    .foregroundColor(.black)
                    .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideVerticalPadding)
                    .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideHorizontalPadding)
                    .background(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
                        .foregroundColor(.white)
                        .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero))
            }
            Text("\(shotCount)")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.primaryBrown)
                .frame(width: AddCaffeineDetailViewLayoutValue.Sizes.stepperValueFixedWidth, height: AddCaffeineDetailViewLayoutValue.Sizes.stepperValueFixedHeight, alignment: .center)
                .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideVerticalPadding)
                .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideHorizontalPadding)
                .background(Rectangle()
                    .foregroundColor(.white)
                    .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero))
            Button {
                shotCount += 1
            } label: {
                Image(systemName: "plus")
                    .frame(width: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedWidth, height: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedHeight, alignment: .center)
                    .foregroundColor(.black)
                    .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideVerticalPadding)
                    .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideHorizontalPadding)
                    .background(RoundedCornersShape(corners: [.topRight, .bottomRight], radius: AddCaffeineDetailViewLayoutValue.CornerRadius.cardRadius)
                        .foregroundColor(.white)
                        .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadowRadius, x: .zero, y: .zero))
            }

        }
    }
}

struct AddCaffeineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCaffeineDetailView()
    }
}
