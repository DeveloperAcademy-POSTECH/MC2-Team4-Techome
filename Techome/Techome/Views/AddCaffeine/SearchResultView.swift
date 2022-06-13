//
//  SearchResultView.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/13.
//

import SwiftUI

struct SearchResultView: View {
    var body: some View {
        Text("검색 결과 없음")
        .padding(EdgeInsets(top: SearchCaffeineViewLayoutValue.Padding.cardVerticalPadding, leading: .zero, bottom: .zero, trailing: .zero))    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}
