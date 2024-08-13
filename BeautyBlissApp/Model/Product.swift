//
//  Product.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import SwiftUI

struct ImageData: Decodable {
    let type: String
    let data: [UInt8]
}

struct Product: Identifiable, Decodable {
    let _id: String
    var id: String {
        return _id
    }
    let brand: String
    var name: String
    var salary: Int
    var image: ImageData
    var productInfo: String?
    let category: String
    var stock: Bool
}
