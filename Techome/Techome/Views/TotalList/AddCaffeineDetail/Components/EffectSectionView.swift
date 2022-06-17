//
//  EffectSectionView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import SwiftUI

struct EffectSectionView: View {
    var body: some View {
        Group {
            EffectSectionAddCaffeineAmountProviderView()
            CaffeineResidualTimeProviderView()
        }
        .background(EffectSectionBackground())
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.cardVertical)
        .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.vertical)
    }
}

struct EffectSectionAddCaffeineAmountProviderView: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                Image(systemName: "circle.hexagongrid")
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.sectionIconToText)
                //TODO: 임시 더미데이터 변경 필요
                Text("추가되는 카페인은 \( addCaffeineDetailStates.addedShotCount * addCaffeineDetailStates.beverge.franchise.getCaffeinPerShot()) 입니다.")
                    .fontWeight(.semibold)
            }
            .headlineModifier()
            
            Divider()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
            CurrentCaffeineAmount()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
            AfterCaffeineAmount()
        }
        .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideHorizontal)
    }
}

struct CurrentCaffeineAmount: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder

    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Text("현재")
                .sideEffectValueTitle()
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                //TODO: 임시 더미데이터 변경 필요
                Text("\(Int(IntakeManager.shared.getRemainCaffeineAmount()))")
                    .font(.title2)
                    .fontWeight(.semibold)
                //TODO: customBlack으로 변경 필요
                    .foregroundColor(.black)
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.addCaffeineAmountToUnit)
                Text("mg")
                    .font(.footnote)
                    .foregroundColor(.secondaryTextGray)
            }
        }
    }
}

struct AfterCaffeineAmount: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Text("섭취 후")
                .sideEffectValueTitle()
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                //TODO: 임시 더미데이터 변경 필요
                Text("\(Int(IntakeManager.shared.getRemainCaffeineAmount()) + addCaffeineDetailStates.addedShotCount * addCaffeineDetailStates.beverge.franchise.getCaffeinPerShot())")
                    .fontWeight(.semibold)
                    .sideEffectValueHighlight()
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.addCaffeineAmountToUnit)
                Text("mg")
                    .font(.footnote)
                    .foregroundColor(.secondaryTextGray)
            }
        }
    }
}
struct CaffeineResidualTimeProviderView: View {
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                Image(systemName: "timer")
                    .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.sectionIconToText)
                //TODO: 임시 더미데이터 변경 필요
                Text("카페인 배출에 \(addCaffeineDetailStates.calculatedHour(caffenineAmount:addCaffeineDetailStates.addedShotCount))시간 \(addCaffeineDetailStates.calculatedMinute(caffenineAmount:addCaffeineDetailStates.addedShotCount))분이 더 소요됩니다.")
                    .fontWeight(.semibold)
            }
            .headlineModifier()
            Divider()
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
            HStack(alignment: .center, spacing: .zero) {
                Text("예상 배출 완료 시간")
                    .sideEffectValueTitle()
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text("오후")
                        .sideEffectSectionTimeUnit()
                    Text("\(addCaffeineDetailStates.calculatedHour(caffenineAmount:addCaffeineDetailStates.currentCaffeineAmount + addCaffeineDetailStates.addedShotCount))")
                        .fontWeight(.bold)
                        .sideEffectValueHighlight()
                    Text("시")
                        .sideEffectSectionTimeUnit()
                    Text("\(addCaffeineDetailStates.calculatedMinute(caffenineAmount:addCaffeineDetailStates.currentCaffeineAmount + addCaffeineDetailStates.addedShotCount))")
                        .fontWeight(.bold)
                        .sideEffectValueHighlight()
                    Text("분")
                        .sideEffectSectionTimeUnit()
                }
            }
        }
        .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
        .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideHorizontal)
    }
}

struct EffectSectionBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
            .foregroundColor(.white)
            .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero)
    }
}


struct EffectSectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        let addCaffeineDetailStates = AddCaffeineDetailStateHolder(beverage: dummyBeverages[0])
        EffectSectionView()
            .environmentObject(addCaffeineDetailStates)
    }
}
