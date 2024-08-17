//
//  HomeCardViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 17.08.2024.
//

import SwiftUI

class HomeCardViewModel: ObservableObject {
    
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
}
