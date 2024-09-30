//
//  Favorite.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 23.09.2024.
//

import Foundation

struct Favorite: Decodable, Identifiable {
    var _id: String
    var id: String {
        return _id
    }
    var productId: String
    var userId: String
    var isActive: Bool
}
