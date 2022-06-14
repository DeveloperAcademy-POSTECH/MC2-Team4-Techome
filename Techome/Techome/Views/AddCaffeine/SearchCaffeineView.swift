//
//  addCaffeine.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/09.
//

import SwiftUI

struct SearchCaffeineView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var searchCaffeineStateHolder: SearchCaffeineStateHolder
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                    .ignoresSafeArea()
            
                VStack {
                    SearchBarView()
                    
                    // TODO: 더미데이터가 아닌 데이터 연동
                    if (searchCaffeineStateHolder.searchText == "") {
                        RecentlyAddedCaffeine()
                    } else {
                        SearchResultView()
                    }
                }
                .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardHorizontalPadding)
                .frame(height: SearchCaffeineViewLayoutValue.Size.mainHeight * 0.8, alignment: .top)
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
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardTitleHorizontalPadding)
            
            VStack(spacing: .zero) {
                if IntakeManager.shared.getRecentRecords(count: 6).count != 0 {
                    
                    VStack(spacing: .zero) {
                        ForEach (IntakeManager.shared.getRecentRecords(count: 6), id: \.self) { record in
                            CaffeineRecordRow(recentRecord: record)
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.card)
                        .foregroundColor(.white)
                        .shadow(color: .secondaryShadowGray, radius: SearchCaffeineViewLayoutValue.Radius.shadow, x: .zero, y: .zero)
                        )
                } else {
                    Text("최근 추가된 카페인이 없습니다.")
                        .padding(.top, 150)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(EdgeInsets(top: SearchCaffeineViewLayoutValue.Padding.cardVerticalPadding, leading: .zero, bottom: .zero, trailing: .zero))
    }
}

struct CaffeineRecordRow: View {
    
    var recentRecord: IntakeRecord
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                VStack (alignment: .leading){
                    Text(recentRecord.beverage.name)
                        .font(.title3)
                    Text("\(recentRecord.beverage.franchise.rawValue)")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                }
                Spacer()
                HStack (alignment: .firstTextBaseline, spacing: .zero){
                    Text("\(recentRecord.size.caffeineAmount)")
                        .font(.title3)
                    Text(" mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardItemHorizontalPadding)
            .padding(.vertical, SearchCaffeineViewLayoutValue.Padding.cardItemVerticalPadding)
            Divider()
            
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
