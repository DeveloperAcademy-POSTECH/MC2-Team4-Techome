//
//  addCaffeine.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/09.
//

import SwiftUI

struct SearchCaffeineView: View {
    
    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var searchCaffeineStateHolder: SearchCaffeineStateHolder
    @StateObject var searchCaffeineStateHolder = SearchCaffeineStateHolder()
    
    
    var body: some View {
        NavigationView {
            GeometryReader { _ in
                ZStack {
                    Color.backgroundCream
                        .ignoresSafeArea()
                    
                    VStack {
                        SearchBarView()
                            .environmentObject(searchCaffeineStateHolder)
                        if (searchCaffeineStateHolder.searchText == "") {
                            RecentlyAddedCaffeine()
                            
                        } else {
                            SearchResultView()
                                .environmentObject(searchCaffeineStateHolder)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, SearchCaffeineViewLayoutValue.Padding.cardBottomPadding)
                    .frame(maxHeight: .infinity)
//                    .ignoresSafeArea(.keyboard)
                    .padding(.top, SearchCaffeineViewLayoutValue.Padding.mainVertical)
                    .frame(height: SearchCaffeineViewLayoutValue.Size.mainHeight, alignment: .top)
                }
                .frame(width: screenWidth, height: screenHeight)
                .background(.mint)
            }
            .navigationTitle("카페인 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("취소")
                            .foregroundColor(.primaryBrown)
                    }
                }
            }
        }
    }
}

struct RecentlyAddedCaffeine: View {
    
    var body: some View {
        
        VStack {
            Text("최근 추가한 카페인")
                .font(.body)
                .foregroundColor(.customBlack)
                .fontWeight(.semibold)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardTitleHorizontalPadding)
            
            VStack(spacing: .zero) {
                if IntakeManager.shared.getRecentRecords(count: SearchCaffeineViewLayoutValue.Number.recentRecords).isEmpty {
                    Text("최근 추가된 카페인이 없습니다.")
                        .padding(.top, 150)
                        .foregroundColor(.customBlack)
                } else {
                    VStack(spacing: .zero) {
                        ForEach (IntakeManager.shared.getRecentRecords(count: SearchCaffeineViewLayoutValue.Number.recentRecords), id: \.self) { record in
                            CaffeineRecordRow(recentRecord: record)
                            if record != IntakeManager.shared.getRecentRecords(count: SearchCaffeineViewLayoutValue.Number.recentRecords).last {
                                Divider()
                            }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.card)
                        .foregroundColor(.white)
                        .shadow(color: .primaryShadowGray, radius: SearchCaffeineViewLayoutValue.Radius.shadow, x: .zero, y: .zero)
                    )
                }
            }
        }
        .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardHorizontalPadding)
        .padding(.top, SearchCaffeineViewLayoutValue.Padding.cardTopPadding)
    }
}

struct CaffeineRecordRow: View {
    
    var recentRecord: IntakeRecord
    
    var body: some View {
        NavigationLink(destination: {
            AddCaffeineDetailView(beverage: recentRecord.beverage, size: recentRecord.size)
        }) {
            VStack(spacing: .zero) {
                HStack(alignment: .center, spacing: .zero) {
                    VStack (alignment: .leading){
                        Text(recentRecord.beverage.name)
                            .multilineTextAlignment(.leading)
                        Text("\(recentRecord.beverage.franchise.rawValue)")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                    Spacer()
                    HStack (alignment: .firstTextBaseline, spacing: .zero){
                        Text("\(recentRecord.size.name)기준")
                            .font(.caption2)
                            .foregroundColor(.secondaryTextGray)
                            .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.sizeCriterion)
                        Text("\(recentRecord.size.caffeineAmount)")
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
            }
        }
    }
}

struct SearchCaffeineView_Previews: PreviewProvider {
    
    static var previews: some View {
        let searchCaffeineStateHolder = SearchCaffeineStateHolder()
        SearchCaffeineView()
            .environmentObject(searchCaffeineStateHolder)
    }
}
