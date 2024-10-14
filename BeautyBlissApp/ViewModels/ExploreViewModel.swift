//
//  ExploreViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 14.10.2024.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    
    @Published var products = [Product]()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        
        ProductServices.fetchProduct { result in
            switch result {
            case .success(let data):
                guard let products = try? JSONDecoder().decode([Product].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.products = products
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filteredProducts(_ query: String) -> [Product] {
        let lowercasedQuery = query.lowercased()
        return products.filter({ $0.name.lowercased().contains(lowercasedQuery) || $0.brand.lowercased().contains(lowercasedQuery)})
    }
}

