//
//  ChartViewLayoutValue.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import SwiftUI

struct ChartViewLayoutValue {
    struct Padding {
        struct Chart {
            static let weekDayTop: CGFloat = 8
            static let weekDayBottom: CGFloat = 13
            static let weekDayHorizontal: CGFloat = 35.47
        }
    }
    
    struct Size {
        struct Chart {
            static let width: CGFloat = 360
            static let height: CGFloat = 454
            static let chartLineWidth: CGFloat = 323
            static let chartLineHeight: CGFloat = 278
            static let chartCellWidth: CGFloat = 45
            static let chartCellHeight: CGFloat = 192
            static let barWidth: CGFloat = 28
            static let maxBarHeight: CGFloat = 183
            static let indicatorWidth: CGFloat = 118
            static let indicatorHeight: CGFloat = 83
        }
    }
    
    struct Radius {
    }
}
