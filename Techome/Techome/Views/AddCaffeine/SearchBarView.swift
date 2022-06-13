//
//  SearchBar.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/12.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.secondaryTextGray : Color.primaryBrown
                )
            
            TextField("메뉴 또는 브랜드", text: $searchText)
                .disableAutocorrection(true)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.primaryBrown)
                        .padding(SearchCaffeineViewLayoutValue.Padding.searchBarClearTotal)
                        .padding(.trailing, SearchCaffeineViewLayoutValue.Padding.searchBarClearRight)
                        .opacity(searchText.isEmpty ?  0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
                
        }
        .font(.headline)
        .padding(.leading, SearchCaffeineViewLayoutValue.Padding.searchBarGlassLeft)
        .frame(height: SearchCaffeineViewLayoutValue.Size.searchBarHeight, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: SearchCaffeineViewLayoutValue.Radius.searchbar)
                .fill(.white)
                .shadow(color: .secondaryShadowGray, radius: SearchCaffeineViewLayoutValue.Radius.shadow, x: .zero, y: .zero)
        )
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
