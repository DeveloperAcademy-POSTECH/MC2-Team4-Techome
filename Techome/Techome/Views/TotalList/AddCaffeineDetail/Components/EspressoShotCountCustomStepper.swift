//
//  EspressoShotCountCustomStepper.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import SwiftUI

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

struct EspressoShotCountCustomStepper: View {
    //TODO: 임시 더미 데이터
    @EnvironmentObject var addCaffeineDetailStates: AddCaffeineDetailStateHolder
    var ShotCount = 0
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Button {
                addCaffeineDetailStates.shotCount -= 1
                addCaffeineDetailStates.addedShotCount -= 1
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(.black)
                    .shotCountStepperModifier()
                    .background(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
                        .foregroundColor(.white)
                        .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero))
            }
            .disabled(addCaffeineDetailStates.shotCount <= 1)
            Text("\(addCaffeineDetailStates.shotCount)")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.primaryBrown)
                .shotCountStepperModifier()
                .background(Rectangle()
                    .foregroundColor(.white)
                    .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero))
            Button {
                addCaffeineDetailStates.shotCount += 1
                addCaffeineDetailStates.addedShotCount += 1
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .shotCountStepperModifier()
                    .background(RoundedCornersShape(corners: [.topRight, .bottomRight], radius: AddCaffeineDetailViewLayoutValue.CornerRadius.card)
                        .foregroundColor(.white)
                        .shadow(color: .primaryShadowGray, radius: AddCaffeineDetailViewLayoutValue.CornerRadius.shadow, x: .zero, y: .zero))
            }
        }
    }
}
