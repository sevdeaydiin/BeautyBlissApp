//
//  LocaleKeys.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 9.07.2024.
//

import SwiftUI

struct LocaleKeys {
    enum Login: String {
        case login = "login"
        case welcome = "welcomeBack"
        case member = "notAMember"
        case join = "joinUs"
        case email = "email"
        case password = "password"
    }
}

extension String {
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
