//
//  AddCaffeineDetailCustomModifier.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import Foundation
import SwiftUI

extension View {
    func headlineModifier() -> some View {
        modifier(EffectSectionTextModifier.HeadlineModifier())
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

struct EffectSectionTextModifier {
    struct HeadlineModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.subheadline)
                .foregroundColor(.primaryBrown)
                .padding(.bottom, AddCaffeineDetailViewLayoutValue.Paddings.EffectCard.insideVertical)
        }
    }
}

struct ShotCountStepperModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedWidth, height: AddCaffeineDetailViewLayoutValue.Sizes.stepperStepFixedHeight, alignment: .center)
            //.foregroundColor(.black)
            .padding(.vertical, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideVertical)
            .padding(.horizontal, AddCaffeineDetailViewLayoutValue.Paddings.stepperInsideHorizontal)
            //.background(RoundedCornersShape(corners: [.topRight, .bottomRight], radius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
               // .foregroundColor(.white)
                //.shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero))
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
