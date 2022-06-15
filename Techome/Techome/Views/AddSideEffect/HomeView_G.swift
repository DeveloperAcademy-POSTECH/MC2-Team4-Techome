
//
//  Home.swift
//  Techome
//
//  Created by 김유나 on 2022/06/10.
//

import SwiftUI

struct Home: View {
    @State private var showModal = false
    
    var sideEffectStates = AddSideEffectStateHolder()
    
    var body: some View {
        Button(action: {
            self.showModal = true
        }){
            Text("부작용 추가하기")
        }
        .sheet(isPresented: self.$showModal){
            AddSideEffectView()
                .environmentObject(sideEffectStates)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
