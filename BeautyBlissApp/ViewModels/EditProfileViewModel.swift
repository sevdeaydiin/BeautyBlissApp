//
//  EditProfileViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 7.09.2024.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func save(name: String?, lastname: String?, phoneNo: String?) {
        guard let userNewName = name else { return }
        guard let userNewLastname = lastname else { return }
        guard let userNewPhoneNo = phoneNo else { return }
        
        self.user.name = userNewName
        self.user.lastname = userNewLastname
        self.user.phoneNo = userNewPhoneNo
    }
    
    func uploadUserData(name: String?, lastname: String?, phoneNo: String?) {
        let userId = user.id
        let urlPath = "users/\(userId)"
        
        let url = URL(string: "\(NetworkConstants.baseURL)\(urlPath)")!
        print(url)
        
        AuthServices.makeRequest(urlString: url, reqBody: ["name": name, "lastname": lastname, "phoneNo": phoneNo]) { result in
            DispatchQueue.main.async {
                self.save(name: name, lastname: lastname, phoneNo: phoneNo)
                self.uploadComplete = true
            }
        }
    }
}
