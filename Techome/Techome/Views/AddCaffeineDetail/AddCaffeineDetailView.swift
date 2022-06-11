//
//  AddCaffeineDetailView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/11.
//

import SwiftUI

struct AddCaffeineDetailViewLayoutValue {
    
    struct Paddings {
        
    }
    
    struct Sizes {
        
        
    }
    
    struct CornerRadius {
        
    }
}

struct AddCaffeineDetailView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct FranchiseDrinkSizeButton: View {
    var body: some View {
        Text("프랜차이즈 음료 크기")
    }
}

struct AddCaffeineAmout: View {
    var body: some View {
        Text("카페인 섭취량")
    }
}

struct HowLongCaffeineStay: View {
    var body: some View {
        Text("카페인 배출 소요시간")
    }
}

struct AddCaffeineButton: View {
    var body: some View {
        Text("카페인 추가 버튼")
    }
}

struct EspressoShotCountButton: View {
    var body: some View {
        Text("에스프레소 샷 수 버튼")
    }
}

struct AddCaffeineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCaffeineDetailView()
    }
}
