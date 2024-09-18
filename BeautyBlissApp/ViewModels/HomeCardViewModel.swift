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
    
    func fetchProductById() {
        ProductServices.requestDomain = "\(NetworkConstants.baseURL)product/\(self.product.id)"
        
        DispatchQueue.global(qos: .background).async {
            ProductServices.fetchProductById { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        guard let product = try? JSONDecoder().decode(Product.self, from: data!) else { return }
                        self?.product = product
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
