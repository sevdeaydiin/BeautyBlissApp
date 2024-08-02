//
//  AuthService.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 14.07.2024.
//

import Alamofire

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let parameters: [String: Any] = ["email": email, "passowrd": password]
        
        
    }
}
