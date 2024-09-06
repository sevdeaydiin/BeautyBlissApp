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

struct Product: Identifiable, Decodable, Hashable {
    let _id: String
    var id: String {
        return _id
    }
    let brand: String
    var name: String
    var salary: Double
    var image: ImageData
    var productInfo: String?
    let category: String
    var stock: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Genellikle yalnızca benzersiz ID kullanılır.
    }

    // Eşitlik kontrolü için de Equatable protokolünü uygulayabilirsiniz.
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
