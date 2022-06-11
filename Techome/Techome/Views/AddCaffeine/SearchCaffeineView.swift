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
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .shadow(color: .secondaryTextGray, radius: 2, x: 0, y: 0)
                    
                    
                    Text("최근 추가한 카페인")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(EdgeInsets(top: widthPadding, leading: listTextPadding, bottom: 0, trailing: 0))
                    
                    
                    CaffeineRecordByDay()
                }
                .frame(height: UIScreen.main.bounds.height * 0.8, alignment: .top)
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

struct CaffeineRecordByDay: View {
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach (0 ..< 7) {_ in
                CaffeineRecordRow()
            }
        }
        .background(RoundedRectangle(cornerRadius: 7)
            .foregroundColor(.white)
            .shadow(color: .secondaryTextGray, radius: 2, x: 0, y: 0))
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
            .padding(15)
            Divider()
            
        }
    }
}

struct SearchCaffeineView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchCaffeineView()
    }
}
