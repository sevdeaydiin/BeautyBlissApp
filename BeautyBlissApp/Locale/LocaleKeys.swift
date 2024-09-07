//
//  LocaleKeys.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 9.07.2024.
//

import SwiftUI

struct LocaleKeys {
    enum Onboarding: String {
        case login = "login"
        case welcome = "welcomeBack"
        case member = "notAMember"
        case join = "joinUs"
        case email = "email"
        case password = "password"
        case loading = "loading"
    }
    
    enum CustomTabView: String {
        case home = "home"
    }
    
    enum Profile: String {
        case myOrders = "myOrders"
        case wishlist = "wishlist"
        case myAddress = "myAddress"
        case voucher = "voucher"
        case myAccount = "myAccount"
        case settings = "settings"
        case help = "help"
        case contactUs = "contactUs"
        case logOut = "logOut"
    }
    
    enum Account: String {
        case name = "name"
        case lastname = "lastname"
        case phoneNo = "phoneNo"
        case save = "save"
    }
}

extension String {
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
