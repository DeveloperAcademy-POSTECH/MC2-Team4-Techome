//
//  CaffeineBookView.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/14.
//

import SwiftUI

struct CaffeineBookView: View {
    @StateObject var stateHolder = CaffenineBookStateHolder()
    
    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
//                CategoryRow()
//                    .environmentObject(stateHolder)
                
//                if stateHolder.selectedCategory == .franchise {
                FranchiseRow()
                    .background {
                        VStack(spacing: .zero) {
                            Spacer()
                            
                            Rectangle()
                                .frame(height: CaffeineBookLayoutValue.Size.TopBar.Line.height.rawValue)
                                .foregroundColor(.secondaryShadowGray)
                        }
                    }
                    .environmentObject(stateHolder)
//                }
                
                BeverageList()
                    .frame(width: screenWidth)
                    .background(Color.backgroundCream)
                    .environmentObject(stateHolder)
            }
            .navigationTitle("카페인 찾아보기")
        }
    }
}

struct CaffeineBookView_Previews: PreviewProvider {
    static var previews: some View {
        CaffeineBookView()
            .environmentObject(CaffenineBookStateHolder())
    }
}
