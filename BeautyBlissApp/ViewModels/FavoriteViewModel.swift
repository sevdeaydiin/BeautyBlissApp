//
//  FavoriteViewModel.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 23.09.2024.
//

import SwiftUI
import Combine

class FavoriteViewModel: ObservableObject {
    
    @Published var favoriteProducts: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func loadFavorites() {
        
        self.isLoading = true
        guard let userId = AuthViewModel.shared.currentUser?.id else {
            self.errorMessage = "User not logged in"
            return
        }
        
        ProductServices.fetchFavorite(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let favorites = try JSONDecoder().decode([Favorite].self, from: data)
                        self?.loadProducts(for: favorites)
                    } catch {
                        self?.errorMessage = "Failed to decode favorites"
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                self?.isLoading = false
            }
        }
    }
    
    private func loadProducts(for favorites: [Favorite]) {
        let dispatchGroup = DispatchGroup()
        var products: [Product] = []
        
        for favorite in favorites {
            dispatchGroup.enter()
            
            ProductServices.fetchProductById(productId: favorite.productId) { result in
                switch result {
                case .success(let data):
                    do {
                        let product = try JSONDecoder().decode(Product.self, from: data)
                        products.append(product)
                    } catch {
                        print("Failed to decode product \(error)")
                    }
                case .failure(let error):
                    print("Failed to fetch product: \(error)")
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.favoriteProducts = products
        }
    }
    
    func addFavorite(productId: String) {
        
        guard let userId = AuthViewModel.shared.currentUser?.id else {
            self.errorMessage = "User not logged in"
            return
        }
        
        ProductServices.addFavorite(productId: productId, userId: userId) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print("Product added to favorites")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
