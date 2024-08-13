//
//  Extension.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
