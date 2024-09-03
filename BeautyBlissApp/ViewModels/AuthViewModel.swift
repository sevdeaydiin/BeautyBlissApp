//
//  AuthViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    init() {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        print("Token: \(String(describing: token))")
        //logout()
        //defaults.removeObject(forKey: "jsonweboken")
        
        if let token = token as? String {
            self.isAuthenticated = true
            
            if let userId = defaults.object(forKey: "userid") as? String {
                fetchUser(userId: userId)
                print("User fetch initiated for ID: \(userId)")
            } else {
                print("User ID not found in UserDefaults")
            }
        } else {
            isAuthenticated = false
        }
    }
    
    static let shared = AuthViewModel()
    
    func login(email: String, password: String) {
        let defaults = UserDefaults.standard
        
        AuthServices.login(email: email, password: password) { result in
            print("login func")
            switch result {
            case .success(let data):
                if let data = data {
                    // JSON verisini yazdır
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("Sunucu Yanıtı: \(json)")
                    } else {
                        print("Failed to serialize JSON")
                    }
                    
                    // JSON decode işlemi
                    do {
                        let user = try JSONDecoder().decode(ApiResponse.self, from: data)
                        DispatchQueue.main.async {
                            defaults.set(user.token, forKey: "jsonwebtoken")
                            defaults.set(user.user.id, forKey: "userid")
                            self.isAuthenticated = true
                            self.currentUser = user.user
                            print("logged in")
                        }
                    } catch {
                        print("JSON decode error: \(error.localizedDescription)")
                    }
                } else {
                    print("Data is nil")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUser(userId: String) {
        
        let defaults = UserDefaults.standard
        AuthServices.requestDomain = "\(NetworkConstants.baseURL)users/\(userId)"
        
        AuthServices.fetchUser() { result in
            switch result {
            case .success(let data):
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON Response: \(jsonString)")
                    }
                    
                    let user = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        defaults.setValue(user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user
                        print("User: \(user)")
                    }
                } catch {
                    print("JSON decode error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Fetch user error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
