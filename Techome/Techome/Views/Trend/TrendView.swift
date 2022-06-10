//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
//

import SwiftUI

struct TrendView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    TrendChart()
                    SideEffectRecordsByDay()
                    CaffeineRecordByDay()
                        .padding(15)
                    Button{
                        
                    } label: {
                        Text("전체 리스트 보기")
                            .font(.system(size: 15))
                            .foregroundColor(.secondaryTextGray)
                    }
                    Spacer()
                }
                .navigationTitle("카페인 리포트")
            }
        }
    }
}

struct TrendChart: View {
    let chartWidth: CGFloat = UIScreen.main.bounds.width - 30
    
    var body: some View {
        LazyHStack() {
            TabView {
                ForEach(0..<5) {index in
                    VStack(alignment: .leading, spacing: 0) {
                        TotalCaffeineByDay()
                            .padding(.leading, 15)
                        Spacer()
                    }
                    .frame(maxWidth: chartWidth, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                        .shadow(color: .secondaryTextGray, radius: 2, x: 0, y: 0))
                    .padding(15)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: chartWidth * 1.26, alignment: .center)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(height: chartWidth * 1.26)
    }
}

struct TotalCaffeineByDay: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("하루 평균 섭취량")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
                .padding(.top, 15)
            HStack(alignment: .firstTextBaseline, spacing: 0){
                Text("360")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Text("mg")
                    .font(.body)
                    .foregroundColor(.secondaryTextGray)
            }
            .padding(.bottom, 5)
            Text("2022.06.03~2022.06.09")
                .font(.body)
                .foregroundColor(.secondaryTextGray)
        }
    }
}

struct SideEffectRecordsByDay: View {
    let chartWidth: CGFloat = UIScreen.main.bounds.width - 30
    let columns = [
        GridItem(.flexible(maximum: 80)),
        GridItem(.flexible(maximum: 80))
    ]
    
    var body: some View {
        
        LazyHGrid(rows: columns, spacing: 32) {
            ForEach(0..<10) { idx in
                SideEffectRecord()
                    .padding(.vertical, 14)
            }
        }
        .frame(width: chartWidth, height: chartWidth / 2.4)
        .background(RoundedRectangle(cornerRadius: 7)
            .foregroundColor(.white)
            .shadow(color: .secondaryTextGray, radius: 2, x: 0, y: 0))
    }
}

struct SideEffectRecord: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("esophagitis")
            Text("식도염")
                .font(.subheadline)
        }
    }
}

struct CaffeineRecordByDay: View {
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(0..<10) {_ in
                CaffeineRecordRow()
            }
        }
        .background(RoundedRectangle(cornerRadius: 7)
            .foregroundColor(.white)
            .shadow(color: .secondaryTextGray, radius: 2, x: 0, y: 0))
    }
}

struct CaffeineRecordRow: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading){
                    Text("09:30")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                    HStack(alignment: .firstTextBaseline, spacing: 0){
                        Text("아메리카노")
                            .font(.title3)
                        Text("스타벅스/Tall")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack (alignment: .firstTextBaseline, spacing: 0){
                    Text("150")
                        .font(.title)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(15)
            Divider()
            
        }
    }
}

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView()
    }
}
