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
    @StateObject var trendStates: TrendStateHolder
    var dateIndex: Int
    @Binding var selectionIdx: Int
    func getDay(_ today:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        let currentDateString: String = dateFormatter.string(from: today)
        return currentDateString
    }
    let entry: ChartDataEntry
    let location: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: .zero) {
                Text("총")
                    .font(.footnote)
                //TODO: Manager 에서 총량 받아올떄 사용
                Text("\(Int(self.entry.y))mg")
                    .font(.title)
                    .fontWeight(.bold)
                Text(getDay(trendStates.dateOfRecordsByWeek[selectionIdx][dateIndex]))
                    .font(.footnote).foregroundColor(.black)
                //Text("\(entries.endIndex)")
            }
            .padding(.horizontal, TrendViewLayoutValue.Paddings.chartInsidePadding)
            .padding(.vertical, TrendViewLayoutValue.Paddings.chartIndicatorVertical)
            .background(RoundedRectangle(cornerRadius: TrendViewLayoutValue.Radius.cardRadius)
                .foregroundColor(.chartIndicatorBackgroundGray))
            .frame(width: ChartLayoutValue.ChartIndicatorLayoutValue.infoRectangleWidth)
            .offset(x: self.positionX(proxy, location: self.location))
            // '.id(UUID())' will prevent view from slide animation.
            .id(UUID())
        }
    }
    
    func positionX(_ proxy: GeometryProxy, location: CGFloat) -> CGFloat {
        let selectorCentre = ChartLayoutValue.ChartIndicatorLayoutValue.infoRectangleWidth / 2
        let startX = location - selectorCentre
        
        switch startX {
        case ...0 :
            return 0
        case (proxy.size.width - ChartLayoutValue.ChartIndicatorLayoutValue.infoRectangleWidth)...:
            return proxy.size.width - ChartLayoutValue.ChartIndicatorLayoutValue.infoRectangleWidth
        default:
            return startX
        }
    }
}

struct SelectionLine: View {
    let location: CGPoint?
    let height: CGFloat
    
    var body: some View {
        Group {
            if location != nil {
                self.centreLine()
                    .stroke(lineWidth: ChartLayoutValue.ChartIndicatorLayoutValue.selectionLineWidth)
                    .offset(x: self.location!.x)
                    .foregroundColor(.chartIndicatorBackgroundGray)
                /* '.id(UUID())' will prevent view from slide animation.
                 Because this view is a child view and passed to 'BarChartView' parent, parent might already has animation.
                 So, If you want to disable it, just call '.animation(nil)' instead of '.id(UUID())' */
                    .id(UUID())
            }
        }
    }
    
    func centreLine() -> Path {
        var path = Path()
        let p1 = CGPoint(x: .zero, y: ChartLayoutValue.ChartIndicatorLayoutValue.moveSelectionLineY)
        let p2 = CGPoint(x: .zero, y: ChartLayoutValue.ChartIndicatorLayoutValue.drawSelectionLineY)
        path.move(to: p1)
        path.addLine(to: p2)
        return path
    }
}
