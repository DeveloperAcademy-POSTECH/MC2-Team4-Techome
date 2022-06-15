//
//  UIApplication.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/13.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
