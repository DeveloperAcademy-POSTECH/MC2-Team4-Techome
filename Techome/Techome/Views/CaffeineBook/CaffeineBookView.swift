//
//  CaffeineBookView.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/14.
//

import SwiftUI

struct CaffeineBookView: View {
    let stateHolder = CaffenineBookStateHolder()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryRow()
                    .environmentObject(stateHolder)
                
                if stateHolder.selectedCategory == .franchise {
                    FranchiseRow()
                        .environmentObject(stateHolder)
                }
                
                BeverageList()
                    .frame(width: screenWidth)
                    .background(Color.backgroundCream)
            }
            .navigationTitle("카페인 찾아보기")
        }
        .preferredColorScheme(.light)
    }
}

struct CaffeineBookView_Previews: PreviewProvider {
    static var previews: some View {
        CaffeineBookView()
            .environmentObject(CaffenineBookStateHolder())
    }
}
