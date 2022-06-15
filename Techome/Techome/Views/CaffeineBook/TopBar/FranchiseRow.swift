//
//  FranchiseRow.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

struct FranchiseRow: View {
    @EnvironmentObject var stateHolder: CaffenineBookStateHolder
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(stateHolder.franchises, id: \.self) { franchise in
                    FranchiseCell(franchise: franchise,
                                      isSelected: franchise == stateHolder.selectedFranchise)
                    .onTapGesture {
                        withAnimation(.linear(duration: CaffeineBookAnimationValue.Duration.tabBar.rawValue)) {
                            stateHolder.selectedFranchise = franchise
                        }
                    }
                }
            }
        }
    }
}

struct FranchiseRow_Previews: PreviewProvider {
    static var previews: some View {
        FranchiseRow()
            .environmentObject(CaffenineBookStateHolder())
            .previewLayout(.sizeThatFits)
    }
}
