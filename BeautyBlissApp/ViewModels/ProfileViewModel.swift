//
//  ProfileViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 7.09.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
        chechIsCurrentUser()
    }
    
    func chechIsCurrentUser() {
        if(self.user._id == AuthViewModel.shared.currentUser?._id) {
            self.user.isCurrentUser = true
        }
    }
}
