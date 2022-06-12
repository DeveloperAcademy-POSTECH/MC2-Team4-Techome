//
//  SearchBar.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/12.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText: String = ""
    
    // TODO: 다른 브랜치 merge 후 padding, radius, size 값 변수 적용
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.secondaryTextGray : Color.primaryBrown
                )
            
            TextField("메뉴 또는 브랜드", text: $searchText)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.primaryBrown)
                        .padding(10)
                        .padding(.trailing, 4)
                        .opacity(searchText.isEmpty ?  0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding(.leading, 12)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 48, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .shadow(color: .secondaryShadowGray, radius: 2, x: .zero, y: .zero)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
