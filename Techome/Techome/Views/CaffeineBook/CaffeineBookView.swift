//
//  CaffeineBookView.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/14.
//

import SwiftUI

struct CaffeineBookLayoutValue {
    struct Paddings {
        static let topBarCategoryHorizontal: CGFloat = 0
        static let topBarCategoryTop: CGFloat = 35
        static let topBarCategoryBottom: CGFloat = 10
        static let topBarFranchiseHorizontal: CGFloat = 20
        static let topBarFranchiseTop: CGFloat = 25
        static let topBarFranchiseBottom: CGFloat = 10
        
        static let beverageListTop: CGFloat = 20
        static let beverageListHorizontal: CGFloat = 15
        static let beverageListInnerHorizontal: CGFloat = 19
        static let beverageListDividerWidth: CGFloat = 13
        static let beverageListTextBetweenSizeAndAmount: CGFloat = 7
        static let beverageListTextBetweenAmountAndUnit: CGFloat = 1
    }
    
    struct Sizes {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        
        static let topBarCategoryWidth: CGFloat = screenWidth / 3
        static let topBarCategoryHeight: CGFloat = 17
        static let topBarFranchiseHeight: CGFloat = 15
        static let topBarLineHeight: CGFloat = 3
        
        static let beverageListWidth: CGFloat = screenWidth - 30
        static let beverageListHeight: CGFloat = 69
        static let beverageListCaffeineAmountWidth: CGFloat = 35
    }
    
    struct Radius {
        static let beverageList: CGFloat = 7
        static let shadow: CGFloat = 4
    }
}

struct CaffeineBookView: View {
    @StateObject var stateHolder = CaffenineBookStateHolder()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryRow()
                    .environmentObject(stateHolder)
                
                if stateHolder.selectedCategory == "프렌차이즈" {
                    FranchiseRow()
                        .environmentObject(stateHolder)
                }
                
                BeverageList()
                    .frame(width: CaffeineBookLayoutValue.Sizes.screenWidth)
                    .background(Color.backgroundCream)
            }
            .navigationTitle("카페인 찾아보기")
        }
        .preferredColorScheme(.light)
    }
}

struct CategoryRow: View {
    @EnvironmentObject var stateHolder: CaffenineBookStateHolder
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(CaffenineBookStateHolder.categories, id: \.self) { category in
                CategoryCell(category: category,
                             isSelected: category == stateHolder.selectedCategory)
                    .onTapGesture {
                        stateHolder.selectedCategory = category
                    }
            }
        }
    }
}

struct CategoryCell: View {
    let category: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(category)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(isSelected
                                 ? .customBlack
                                 : .secondaryTextGray)
                .frame(width: CaffeineBookLayoutValue.Sizes.topBarCategoryWidth,
                       height: CaffeineBookLayoutValue.Sizes.topBarCategoryHeight,
                       alignment: .center)
                .padding(.horizontal, CaffeineBookLayoutValue.Paddings.topBarCategoryHorizontal)
                .padding(.top, CaffeineBookLayoutValue.Paddings.topBarCategoryTop)
                .padding(.bottom, CaffeineBookLayoutValue.Paddings.topBarCategoryBottom)
            
            Rectangle()
                .frame(height: CaffeineBookLayoutValue.Sizes.topBarLineHeight)
                .foregroundColor(isSelected
                                 ? .primaryBrown
                                 : .white)
        }
    }
}

struct FranchiseRow: View {
    @EnvironmentObject var stateHolder: CaffenineBookStateHolder
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(CaffenineBookStateHolder.franchises, id: \.self) { franchise in
                    FranchiseCell(franchise: franchise,
                                      isSelected: franchise == stateHolder.selectedFranchise)
                    .onTapGesture {
                        stateHolder.selectedFranchise = franchise
                    }
                }
            }
        }
    }
}

struct FranchiseCell: View {
    let franchise: Franchise
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(franchise.getFranchiseName())
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(isSelected
                                 ? .customBlack
                                 : .secondaryTextGray)
                .frame(height: CaffeineBookLayoutValue.Sizes.topBarFranchiseHeight, alignment: .center)
                .padding(.top, CaffeineBookLayoutValue.Paddings.topBarFranchiseTop)
                .padding(.bottom, CaffeineBookLayoutValue.Paddings.topBarFranchiseBottom)
                .padding(.horizontal, CaffeineBookLayoutValue.Paddings.topBarFranchiseHorizontal)
            
            Rectangle()
                .frame(height: CaffeineBookLayoutValue.Sizes.topBarLineHeight)
                .foregroundColor(isSelected
                                 ? .primaryBrown
                                 : .white)
        }
    }
}

struct BeverageList: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                RoundedRectangle(cornerRadius: CaffeineBookLayoutValue.Radius.beverageList)
                    .foregroundColor(.white)
                
                LazyVStack(spacing: 0) {
                    ForEach(dummyBeverages, id: \.self) { beverage in
                        BeverageListRow(beverage: beverage)
                    }
                }
                .padding(.horizontal, CaffeineBookLayoutValue.Paddings.beverageListHorizontal)
            }
            .padding(.top, CaffeineBookLayoutValue.Paddings.beverageListTop)
            .frame(width: CaffeineBookLayoutValue.Sizes.beverageListWidth)
        }
        .shadow(color: .primaryShadowGray, radius: 4, x: 0, y: 0)
    }
}

struct BeverageListRow: View {
    let beverage: Beverage
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: {
//                CaffeineBookDetailView(beverage: beverage)
            }) {
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text(beverage.name)
                            .font(.system(size: 19, weight: .regular))
                            .foregroundColor(.customBlack)
                            .multilineTextAlignment(.leading)                        .padding(.horizontal, CaffeineBookLayoutValue.Paddings.beverageListHorizontal)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(beverage.sizeInfo[0].name + " 기준")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryTextGray)
                                .padding(.horizontal, CaffeineBookLayoutValue.Paddings.beverageListTextBetweenSizeAndAmount)
                            
                            Text(String(beverage.sizeInfo[0].caffeineAmount))
                                .font(.system(size: 19, weight: .regular))
                                .foregroundColor(.customBlack)
                                .frame(width: CaffeineBookLayoutValue.Sizes.beverageListCaffeineAmountWidth, alignment: .trailing)
                                .padding(.trailing, CaffeineBookLayoutValue.Paddings.beverageListTextBetweenAmountAndUnit)
                            
                            Text("mg")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryTextGray)
                                .padding(.trailing, CaffeineBookLayoutValue.Paddings.beverageListHorizontal)
                        }
                    }
                    .padding(.horizontal, CaffeineBookLayoutValue.Paddings.beverageListHorizontal)
                    .frame(width: CaffeineBookLayoutValue.Sizes.beverageListWidth, height: CaffeineBookLayoutValue.Sizes.beverageListHeight)
                    
                    Divider()
                }
            }
        }
    }
}

struct CaffeineBookView_Previews: PreviewProvider {
    static var previews: some View {
        CaffeineBookView()
            .environmentObject(CaffenineBookStateHolder())
    }
}
