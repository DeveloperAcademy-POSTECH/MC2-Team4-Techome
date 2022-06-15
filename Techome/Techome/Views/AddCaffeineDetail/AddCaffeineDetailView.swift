//
//  AddCaffeineDetailView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/11.
//

import SwiftUI

struct AddCaffeineDetailViewLayoutValue {
    
    struct Paddings {
        static let section: CGFloat = 42
        static let navigationBarToTitle: CGFloat = 34
        static let sectionTitleToComponent: CGFloat = 15
        static let cardVertical: CGFloat = 15
        static let titleToBrand: CGFloat = 5
        static let addCaffeineAmountToUnit: CGFloat = 3
        
        enum DrinkSizeButton {
            static let horizontal: CGFloat = 3
            static let insideHorizontal: CGFloat = 44
            static let insideVertical: CGFloat = 13.5
        }
        
        
        enum EffectCard {
            static let vertical: CGFloat = 15
            static let insideHorizontal: CGFloat = 18
            static let insideVertical: CGFloat = 14
            static let dividerHorizontal: CGFloat = 10
            static let sectionIconToText: CGFloat = 6
        }
        
        enum Stepper {
            static let insideVertical: CGFloat = 14
            static let insideHorizontal: CGFloat = 49
        }
    }
    
    struct Sizes {
        static let addCaffeineButtonHeight: CGFloat = 60
        static let stepperStepFixedWidth: CGFloat = 17
        static let stepperStepFixedHeight: CGFloat = 15
        static let stepperValueFixedWidth: CGFloat = 20
        static let stepperValueFixedHeight: CGFloat = 15
    }
    
    struct CornerRadius {
        static let card: CGFloat = 5
        static let shadow: CGFloat = 2
    }
}

struct AddCaffeineDetailView: View {
    @EnvironmentObject var addCaffeineStates: AddCaffeineDetailStateHolder
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: .zero) {
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text(addCaffeineStates.bevergeRecord.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, AddCaffeineDetailViewLayoutValue.Paddings.cardVertical)
                    Text(addCaffeineStates.bevergeRecord.franchise.getFranchiseName())
                        .font(.title3)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.leading, AddCaffeineDetailViewLayoutValue.Paddings.titleToBrand)
                    Spacer()
                }
                .padding(.top, AddCaffeineDetailViewLayoutValue.Paddings.navigationBarToTitle)
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.section)
                
                HStack(alignment: .center, spacing: .zero) {
                    Text("사이즈")
                    Spacer()
                }
                .sectionTitleModifier()
                
                FranchiseDrinkSizeButtonsGroupView()
                    .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.section)
                
                HStack(alignment: .center, spacing: .zero) {
                    Text("에스프레소 샷 수")
                    Spacer()
                }
                .sectionTitleModifier()
                EspressoShotCountCustomStepper()
                    .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.section)
                HStack(alignment: .center, spacing: .zero) {
                    Text("영향")
                    Spacer()
                }
                .sectionTitleModifier()
                EffectSectionView()
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

struct AddCaffeineButton: View {
    var body: some View {
        Button {
            //TODO: 추가하기 시 동작
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
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
            .foregroundColor(.primaryBrown)
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVertical)
            .frame(width: UIScreen.main.bounds.width, height: AddCaffeineDetailViewLayoutValue.Sizes.addCaffeineButtonHeight, alignment: .center)
    }
}

struct AddCaffeineDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let addCaffeineDetailState = AddCaffeineDetailStateHolder()
        AddCaffeineDetailView()
            .environmentObject(addCaffeineDetailState)
    }
}
