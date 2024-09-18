//
//  User.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 3.08.2024.
//

import Foundation

struct ApiResponse: Decodable {
    var user: User
    var token: String
}

struct User: Decodable, Identifiable {
    var _id: String
    var id: String {
        return _id
    }
    var name: String
    var lastname: String
    let email: String
    var phoneNo: String
    var birthday: String?
    var gender: Bool?
    var orders: [String]?
    var favorites: [String]?
    var clubScore: Int?
    var clubNo: Int?
    var isCurrentUser: Bool? = false
}
