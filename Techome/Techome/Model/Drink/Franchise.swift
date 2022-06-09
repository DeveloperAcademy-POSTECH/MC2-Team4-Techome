//
//  Franchise.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

enum Franchise: String{
    case starbucks = "스타벅스"
    case twosomePlace = "투썸플레이스"

    func getCaffeinPerShot() -> Int{
        switch(self){
        case .starbucks:
            return 75
        case .twosomePlace:
            return 50
        }
    }

    func getSizeName(index: Int) -> String{
        switch(self){
        case .starbucks:
            let names = ["Tall", "Grande", "Venti"]
            return names[index]

        case .twosomePlace:
            let names = ["Regular", "Large", "Max"]
            return names[index]
        }
    }

    func getSizeAmount(index: Int) -> Int{
        switch(self){
        case .starbucks:
            let names = [355, 473, 591]
            return names[index]

        case .twosomePlace:
            let names = [355, 473, 591]
            return names[index]
        }
    }
}
