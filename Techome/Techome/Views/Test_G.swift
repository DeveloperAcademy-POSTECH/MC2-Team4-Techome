//
//  Test_G.swift
//  Techome
//
//  Created by 김유나 on 2022/06/14.
//

import SwiftUI

struct Test_G: View {
    @State var searchString: String = ""
    let beverageManager = BeverageManager.shared
    
    var body: some View {
        TextField("Your Location", text: $searchString)
            .onChange(of: searchString) {
                onChangeString(searchString: $0)
            }
    }
    
    func onChangeString(searchString: String) {
        let result = beverageManager.getSatisfiedBeveragesByString(searchString: searchString)
        print(result)
    }
}

struct Test_G_Previews: PreviewProvider {
    static var previews: some View {
        Test_G()
    }
}
