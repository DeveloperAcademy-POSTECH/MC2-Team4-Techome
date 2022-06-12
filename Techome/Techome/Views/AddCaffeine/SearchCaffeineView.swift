//
//  addCaffeine.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/09.
//

import SwiftUI

struct SearchCaffeineView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let widthPadding = 15.0
    let listTextPadding = 10.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                    .ignoresSafeArea()
            
                VStack {
                    RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.cardRadius)
                        .frame(height: SearchCaffeineViewLayoutValue.Size.searchBarHeight)
                        .foregroundColor(.white)
                        .shadow(color: .secondaryTextGray, radius: SearchCaffeineViewLayoutValue.Radius.shadowRadius, x: .zero, y: .zero)
                    
                    
                    Text("최근 추가한 카페인")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.horizontal, SearchCaffeineViewLayoutValue.Padding.cardTitleHorizontalPadding)
                        .padding(EdgeInsets(top: SearchCaffeineViewLayoutValue.Padding.cardVerticalPadding, leading: .zero, bottom: .zero, trailing: .zero))
                    
                    
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
        VStack(spacing: 0) {
            ForEach (0 ..< 7) { _ in
                CaffeineRecordRow()
            }
        }
        .background(RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.cardRadius)
            .foregroundColor(.white)
            .shadow(color: .secondaryTextGray, radius: SearchCaffeineViewLayoutValue.Radius.shadowRadius, x: 0, y: 0))
    }
}

struct CaffeineRecordRow: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack (alignment: .leading){
                    Text("아메리카노")
                        .font(.title3)
                    Text("스타벅스/Tall")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                }
                Spacer()
                HStack (alignment: .firstTextBaseline, spacing: 0){
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
