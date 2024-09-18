//
//  ProductViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products = [Product]()
    @Published var filteredProducts: [Product] = []
    @Published var selectedCategory: String = "All"
    @Published var categories: [String] = ["All", "Foundation", "Powder", "Mascara", "Lips", "Blush"]
    
    init() {
        fetchProducts()
        filterProducts(by: categories.description)
    }
    
    func fetchProducts() {
        
        ProductServices.requestDomain = "\(NetworkConstants.baseURL)product"
        
        DispatchQueue.global(qos: .background).async {
            ProductServices.fetchProduct { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        do {
                            let json = String(data: data!, encoding: .utf8)
                            let products = try JSONDecoder().decode([Product].self, from: data!)
                            self?.products = products
                            
                        } catch {
                            print("json decode error \(error)")
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func filterProducts(by category: String) {
        if category == "All" {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { $0.category == category }
        }
    }
    
}
