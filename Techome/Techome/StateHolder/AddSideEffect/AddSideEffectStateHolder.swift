//
//  AddSideEffectStateHolder.swift
//  Techome
//
//  Created by 김유나 on 2022/06/13.
//

import Foundation

class AddSideEffectStateHolder: ObservableObject {
    
    let sideEffectManager = SideEffectManager.shared
    let totalSideEffectList: [SideEffect] = SideEffect.allCases
    
    @Published var sideEffectDate = Date()
    @Published var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false]
    @Published var isDisabled: Bool = true
    
    var selectedSideEffectTypes: [SideEffect] = []
    
    func onButtonTouched(sideEffectIndex: Int) {
        
        isSelected[sideEffectIndex].toggle()
        isDisabled = isSelected.contains(true) ? false : true

//        for eachSelected in isSelected {
//            if eachSelected == true {
//                isDisabled = false
//                break
//            }
//            isDisabled = true
//        }
        
    }

    
    func onSavedPressed() {
        for selectedIndex in isSelected.indices {
            if isSelected[selectedIndex] == true {
                selectedSideEffectTypes.append(totalSideEffectList[selectedIndex])
            }
        }
        sideEffectManager.addRecord(date: sideEffectDate, sideEffects: selectedSideEffectTypes)
    }
}
