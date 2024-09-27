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
            errorMessage = "User not found"
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
    
}

/*class FavoriteViewModel: ObservableObject {
    
    //@Published var favoriteResponse: [String: Any]?
    @Published var errorMessage: String?
    @Published var favorites: [Favorite] = []
    
    init() {
        //self.favoriteProduct = favorite
        fetchFavorites(userId: AuthViewModel.shared.currentUser?.id ?? "")
    }
    
    func addFavorite(productId: String, userId: String) {
            ProductServices.addFavorite(productId: productId, userId: userId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print("Successfully added to favorites: \(response)")
                        self?.fetchFavorites(userId: userId)
                    case .failure(let error):
                        self?.errorMessage = "Failed to add to favorites: \(error.localizedDescription)"
                    }
                }
            }
        }
    
    func fetchFavorites(userId: String) {
        ProductServices.fetchFavorite(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let favorites = try JSONDecoder().decode([Favorite].self, from: data)
                        self?.favorites = favorites
                    } catch {
                        self?.errorMessage = "Failed to decode favorites: \(error.localizedDescription)"
                    }
                    //guard let favorite = try? JSONDecoder().decode([Favorite].self, from: data) else { return }
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch favorites: \(error.localizedDescription)"
                }
            }
        }
    }

}*/
