//
//  AddSideEffectStateHolder.swift
//  Techome
//
//  Created by 김유나 on 2022/06/13.
//

import Foundation

class AddSideEffectStateHolder: ObservableObject {
    
    @Published var sideEffectDate = Date()
    @Published var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false]
    
    func onButtonTouched(sideEffectIndex: Int) {
        isSelected[sideEffectIndex].toggle()
    }
}
