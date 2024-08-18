//
//  ProductInfoViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 18.08.2024.
//

import SwiftUI

class ProductInfoViewModel: ObservableObject {
    
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
}
