//
//  ChartSelectionIndicatorView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import SwiftUI
import BarChart

///https://github.com/romanbaitaliuk/BarChart
struct ChartSelectionIndicatorView: View {
    func getDay(_ today:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        let currentDateString: String = dateFormatter.string(from: today)
        return currentDateString    }
    
    let entry: ChartDataEntry
    let location: CGFloat
    let infoRectangleWidth: CGFloat = 130
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                Text("총")
                    .font(.footnote)
                Text("\(Int(self.entry.y))mg")
                    .font(.title)
                    .fontWeight(.bold)
                Text(getDay(Date()))
                    .font(.footnote).foregroundColor(.black)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 7)
                .foregroundColor(.chartIndicatorBackgroundGray))
            .frame(width: self.infoRectangleWidth)
            .offset(x: self.positionX(proxy, location: self.location))
            // '.id(UUID())' will prevent view from slide animation.
            .id(UUID())
        }
    }
    
    func positionX(_ proxy: GeometryProxy, location: CGFloat) -> CGFloat {
        let selectorCentre = self.infoRectangleWidth / 2
        let startX = location - selectorCentre
        if startX < 0 {
            return 0
        } else if startX + self.infoRectangleWidth > proxy.size.width {
            return proxy.size.width - self.infoRectangleWidth
        } else {
            return startX
        }
    }
}

