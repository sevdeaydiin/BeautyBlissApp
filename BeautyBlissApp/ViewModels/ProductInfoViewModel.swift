//
//  ProductInfoViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 6.09.2024.
//

import SwiftUI

class ProductInfoViewModel: ObservableObject {
    
    @Published var productArray = [Product]()
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func fetchProductById() {
        ProductServices.requestDomain = "\(NetworkConstants.baseURL)product/\(self.product.id)"
        
        ProductServices.fetchProductById { result in
            switch result {
            case .success(let data):
                guard let product = try? JSONDecoder().decode([Product].self, from: data!) else { return }
                DispatchQueue.main.async {
                    self.productArray = product
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
