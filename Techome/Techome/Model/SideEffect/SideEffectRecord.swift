//
//  SideEffectRecord.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

typealias SideEffectIndex = Int

struct SideEffectRecord{
    var date: String
    var sideEffectIndices: [SideEffectIndex]
}

let sideEffects: [String] = [
    "두근거림", "불안감", "손떨림", "무기력", "탈수", "현기증", "식도염", "불면증", "우울함", "속쓰림"
]
