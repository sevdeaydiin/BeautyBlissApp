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
                        }
                    } else {
                        Text("Favorite list is empty.")
                            .padding()
                            .background(Color.gray.opacity(0.07))
                            .padding()
                    }  
                }
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
        .background(Color.gray.opacity(0.07))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FavoriteCard: View {
    
    var product: Product
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.darkBg)
            .frame(width: Sizes.width * 0.45, height: Sizes.height * 0.35)
            .shadow(color: .lightGray, radius: 5)
            .overlay {
                VStack(spacing: 25) {
                    Spacer()
                    
                    if let uiImage = UIImage(data: Data(self.product.image.data)) {
                        KFImage(source: .provider(KFImageProvider(image: uiImage)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Sizes.width * 0.3, height: Sizes.width * 0.3)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(self.product.brand)
                            .lineLimit(1)
                            .foregroundStyle(.myGray)
                        Text(self.product.name)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundStyle(.lightTheme)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("$\(self.product.salary, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundStyle(.first)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 2)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 2)
            }
            .overlay(
                Image(systemName: "heart.fill")
                    .foregroundStyle(.first)
                    .font(.title2)
                    .position(x: 155, y: 25)
            )
    }
}
