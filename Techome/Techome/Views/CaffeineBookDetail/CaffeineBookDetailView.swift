//
//  CaffeineBookDetailView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/14.
//

import SwiftUI

struct CaffeineBookDetailLayoutValue {
    
    struct Padding {
        static let backgroundTop: CGFloat = 15
        static let backgroundHorizantal: CGFloat = 15
        static let titleTop: CGFloat = 43
        static let franchiseTop: CGFloat = 8
        static let buttonGroupTop: CGFloat = 38
        static let buttonGroupBottom: CGFloat = 6
        static let buttonBetweenSpace: CGFloat = 21
        static let buttonTextSpace: CGFloat = 12
        static let infoRowBetweenSpaceExceptCaption: CGFloat = 21
        static let infoRowBetweenSpaceCaption: CGFloat = 19
        static let infoRowBottom: CGFloat = 38
        static let infoGroupHorizontal: CGFloat = 19
        static let recommendedAmountTop: CGFloat = 5
    }
    
    struct Size {
        static let sizeButtonWidth: CGFloat = 92
        static let sizeButtonHeight: CGFloat = 98
    }
    
    struct Radius {
        static let backgroundCard: CGFloat = 10
        static let backgroundCardShadow: CGFloat = 4
        static let sizeButton: CGFloat = 5
        static let sizeButtonShadow: CGFloat = 4
    }
    
}

struct CaffeineBookDetailView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(alignment: .center, spacing: .zero) {
                        CaffeineBeverage()
                        CaffeineSizeButtonGroup()
                        CaffeineInfoGroup()
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: CaffeineBookDetailLayoutValue.Radius.backgroundCard))
                    .padding(.horizontal, CaffeineBookDetailLayoutValue.Padding.backgroundHorizantal)
                    .padding(.top, CaffeineBookDetailLayoutValue.Padding.backgroundTop)
                    .shadow(color: Color.primaryShadowGray, radius: CaffeineBookDetailLayoutValue.Radius.backgroundCardShadow, x: .zero, y: .zero)
                    
                    Spacer()
                }
            }
            .navigationTitle("카페인 찾아보기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    print("뒤로가기")
                }) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.primaryBrown)
                }
            )
        }
    }
}

struct CaffeineBeverage: View {
    var body: some View {
        Text("아메리카노")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.customBlack)
            .padding(.top, CaffeineBookDetailLayoutValue.Padding.titleTop)
        
        Text("스타벅스")
            .font(.caption)
            .foregroundColor(.secondaryTextGray)
            .padding(.top, CaffeineBookDetailLayoutValue.Padding.franchiseTop)
    }
}

struct CaffeineSizeButtonGroup: View {
    var body: some View {
        HStack(spacing: CaffeineBookDetailLayoutValue.Padding.buttonBetweenSpace) {
            CaffeineSizeButton(size: "Tall", volume: "355ml")
            CaffeineSizeButton(size: "Grande", volume: "450ml")
            CaffeineSizeButton(size: "Venti", volume: "530ml")
        }
        .padding(.top, CaffeineBookDetailLayoutValue.Padding.buttonGroupTop)
        .padding(.bottom, CaffeineBookDetailLayoutValue.Padding.buttonGroupBottom)
    }
}

struct CaffeineSizeButton: View {
    
    var size: String
    var volume: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: CaffeineBookDetailLayoutValue.Radius.sizeButton)
            .frame(width: CaffeineBookDetailLayoutValue.Size.sizeButtonWidth, height: CaffeineBookDetailLayoutValue.Size.sizeButtonHeight)
            .foregroundColor(.white)
            .shadow(color: Color.primaryShadowGray, radius: CaffeineBookDetailLayoutValue.Radius.sizeButtonShadow, x: .zero, y: .zero)
            .overlay(
                VStack(spacing: .zero) {
                    Text(size)
                        .font(.title2)
                        .foregroundColor(.customBlack)
                    Text(volume)
                        .padding(.top, CaffeineBookDetailLayoutValue.Padding.buttonTextSpace)
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                }
            )
            .onTapGesture {
                print("\(size) 누름")
            }
    }
}

struct CaffeineInfoGroup: View {
    
    var body: some View {
        Group {
            CaffeineInfoRow(label: "샷 수", info: "2샷")
                .padding(.top, CaffeineBookDetailLayoutValue.Padding.infoRowBetweenSpaceExceptCaption)
            CaffeineInfoRow(label: "카페인", info: "175mg")
                .padding(.top, CaffeineBookDetailLayoutValue.Padding.infoRowBetweenSpaceExceptCaption)
            HStack {
                Spacer()
                Text("하루 권장량 400mg")
                    .padding(.top, CaffeineBookDetailLayoutValue.Padding.recommendedAmountTop)
                    .font(.caption)
                    .foregroundColor(.secondaryTextGray)
            }
            CaffeineInfoRow(label: "배출", info: "2시간 45분")
                .padding(.bottom, CaffeineBookDetailLayoutValue.Padding.infoRowBottom)
        }
        .padding(.horizontal, CaffeineBookDetailLayoutValue.Padding.infoGroupHorizontal)
    }
}

struct CaffeineInfoRow: View {
    
    var label: String
    var info: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.customBlack)
            Spacer()
            Text(info)
                .fontWeight(.semibold)
                .foregroundColor(.primaryBrown)
        }
        .padding(.top, CaffeineBookDetailLayoutValue.Padding.infoRowBetweenSpaceCaption)
        .font(.title3)
    }
}

struct CaffeineBookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CaffeineBookDetailView()
    }
}