//
//  FavoriteView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 18.08.2024.
//

import SwiftUI
import Kingfisher

struct FavoriteView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewModel = FavoriteViewModel()
    
    var body: some View {
        VStack {
            Text("Favorite")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.first)
                .padding()
            
            VStack {
                if viewModel.isLoading {
                    LoadingAnimation()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Failed: \(errorMessage)")
                        .foregroundStyle(.red)
                        .padding()
                    Spacer()
                }  else {
                    if !viewModel.favoriteProducts.isEmpty {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(viewModel.favoriteProducts, id: \.id) { product in
                                    FavoriteCard(product: product)
                                    //.onTapGesture {
                                    //viewModel.addFavorite(productId: product.id)
                                    //}
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.07))
                        }
                    } else {
                        TextView()
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadFavorites(userId: AuthViewModel.shared.currentUser?.id ?? "")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
