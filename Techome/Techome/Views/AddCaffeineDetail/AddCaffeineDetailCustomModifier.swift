//
//  AddCaffeineDetailCustomModifier.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import Foundation
import SwiftUI

//TODO: merge 할때 Extension 으로 옮길 예정
extension View {
    func headlineModifier() -> some View {
        modifier(HeadlineModifier())
    }
    func sectionTitleModifier() -> some View {
        modifier(SectionTitleModifier())
    }
    
    func shotCountStepperModifier() -> some View {
        modifier(ShotCountStepperModifier())
    }
    func sideEffectSectionTimeUnit() -> some View {
        modifier(SideEffectSectionTimeUnit())
    }
    func sideEffectValueTitle() -> some View {
        modifier(SideEffectValueTitle())
    }
    func sideEffectValueHighlight() -> some View {
        modifier(SideEffectValueHighlight())
    }
}

struct SectionTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.black)
            .padding(.leading, AddCaffeineDetailViewLayoutValue.Paddings.sectionTitleToComponent)
            .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
    }
}

struct HeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.primaryBrown)
            .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
    }
}


struct ShotCountStepperModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedWidth, height: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedHeight, alignment: .center)
            .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.Stepper
                .insideVertical)
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.Stepper.insideHorizontal)
    }
}

struct SideEffectSectionTimeUnit: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(.secondaryTextGray)
            .padding(.trailing, AddCaffeineDetailViewLayoutValue.Paddings.addCaffeineAmountToUnit)
    }
}

struct SideEffectValueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.secondaryTextGray)
    }
}

struct SideEffectValueHighlight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.primaryBrown)
    }
}
