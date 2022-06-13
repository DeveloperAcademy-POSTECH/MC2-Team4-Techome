//
//  addCaffeine.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/09.
//

import SwiftUI

struct SearchCaffeineView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                    .ignoresSafeArea()
            
                VStack {
                    // TODO: 커스텀 검색바 구현
                    RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.card)
                        .frame(height: SearchCaffeineViewLayoutValue.Size.searchBarHeight)
                        .foregroundColor(.white)
                        .shadow(color: .secondaryTextGray, radius: SearchCaffeineViewLayoutValue.Radius.shadow, x: .zero, y: .zero)
                    
                    // TODO: 더미데이터가 아닌 데이터 연동
                    RecentlyAddedCaffeine()
                }
                .frame(height: SearchCaffeineViewLayoutValue.Size.mainHeight * 0.8, alignment: .top)
                .padding(.horizontal)
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
                ForEach (0 ..< 7) { _ in
                    CaffeineRecordRow()
                }
            }
            .background(RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.card)
                .foregroundColor(.white)
                .shadow(color: .secondaryTextGray, radius: SearchCaffeineViewLayoutValue.Radius.shadow, x: .zero, y: .zero))
            
        }
        .padding(EdgeInsets(top: SearchCaffeineViewLayoutValue.Padding.cardVerticalPadding, leading: .zero, bottom: .zero, trailing: .zero))
    }
}

struct CaffeineRecordRow: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                VStack (alignment: .leading){
                    Text("아메리카노")
                        .font(.title3)
                    Text("스타벅스/Tall")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                }
                Spacer()
                HStack (alignment: .firstTextBaseline, spacing: .zero){
                    Text("150")
                        .font(.title3)
                    Text("mg")
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
        SearchCaffeineView()
    }
}
