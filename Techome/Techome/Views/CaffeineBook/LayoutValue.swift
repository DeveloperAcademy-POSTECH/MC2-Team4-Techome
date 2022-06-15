//
//  LayoutValue.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/15.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

enum CaffeineBookLayoutValue {
    enum Padding {
        enum TopBar {
            enum Category: CGFloat {
                case horizontal = 0
                case top = 35
                case bottom = 10
            }
            
            enum Franchise: CGFloat {
                case horizontal = 20
                case top = 25
                case bottom = 10
            }
        }
        
        enum BeverageList: CGFloat {
            case top = 20
            case horizontal = 15
            case innerHorizontal = 19
            case textBetweenSizeAndAmount = 7
            case textBetweenAmountAndUnit = 1
        }
    }
    
    enum Size {
        enum TopBar {
            enum Category: CGFloat {
                case height = 17
            }
            
            enum Franchise: CGFloat {
                case height = 15
            }
            
            enum Line: CGFloat {
                case height = 3
            }
        }
        
        enum BeverageList: CGFloat {
            case height = 69
            case caffeineAmountWidth = 35
        }
    }
    
    enum Radius: CGFloat {
        case beverageList = 7
        case shadow = 4
    }
}
