//
//  ProductViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products = [Product]()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
            
        ProductServices.requestDomain = "\(NetworkConstants.baseURL)product"
        ProductServices.fetchProduct { result in
            switch result {
            case .success(let data):
                do {
                    let json = String(data: data!, encoding: .utf8)
                    let products = try JSONDecoder().decode([Product].self, from: data!)
                    DispatchQueue.main.async {
                        self.products = products
                    }
                } catch {
                    print("json decode error \(error)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
