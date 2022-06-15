//
//  SearchResultView.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/13.
//

import SwiftUI

struct SearchResultView: View {
    
    @EnvironmentObject var searchCaffeineStateHolder: SearchCaffeineStateHolder
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("검색")
                    Text("\(searchCaffeineStateHolder.currentItems.count)")
                        .fontWeight(.semibold)
                    Text("건")
                }
                .font(.body)
                .foregroundColor(.customBlack)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardTitleHorizontalPadding)
                
                VStack (spacing: .zero) {
                    if searchCaffeineStateHolder.currentItems.isEmpty {
                        Text("검색 결과 없음")
                            .font(.title3)
                            .foregroundColor(.customBlack)
                            .padding(.top, SearchCaffeineViewLayoutValue.Padding.cardVerticalPadding)
                    } else {
                        LazyVStack (spacing: .zero) {
                            ForEach (searchCaffeineStateHolder.currentItems, id: \.self) { item in
                                SatisfiedCaffeineItem(satisfiedCaffeineItem: item)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.card)
                            .foregroundColor(.white)
                            .shadow(color: .secondaryShadowGray, radius: SearchCaffeineViewLayoutValue.Radius.shadow, x: .zero, y: .zero))
                    }
                }
            }
            .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardHorizontalPadding)
            .padding(.top, SearchCaffeineViewLayoutValue.Padding.cardVerticalPadding)
        }
        .frame(width: SearchCaffeineViewLayoutValue.Size.mainWidth, alignment: .top)
    }
}

struct SatisfiedCaffeineItem: View {
    
    var satisfiedCaffeineItem: Beverage
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                VStack (alignment: .leading){
                    Text(satisfiedCaffeineItem.name)
                        .multilineTextAlignment(.leading)
                    Text("\(satisfiedCaffeineItem.franchise.rawValue)")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                }
                Spacer()
                HStack (alignment: .firstTextBaseline, spacing: .zero){
                    Text("Tall 기준")
                        .font(.caption2)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.sizeCriterion)
                    Text("\(satisfiedCaffeineItem.sizeInfo[0].caffeineAmount)")
                        .font(.title3)
                        .frame(width: SearchCaffeineViewLayoutValue.Size.caffeineAmountText, alignment: .trailing)
                    Text(" mg")
                        .font(.caption2)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .foregroundColor(.customBlack)
            .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardItemHorizontalPadding)
            .padding(.vertical, SearchCaffeineViewLayoutValue.Padding.cardItemVerticalPadding)
            Divider()
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        let searchCaffeineStateHolder = SearchCaffeineStateHolder()
        SearchResultView()
            .environmentObject(searchCaffeineStateHolder)
    }
}
