//
//  User.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 14.07.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let token: String?
}
