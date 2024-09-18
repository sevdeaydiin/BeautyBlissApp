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
    @ObservedObject var viewModel = ProductViewModel()
    var body: some View {
        
        VStack {
            Text("Favorite")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.first)
                .padding()
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    
                    ForEach(viewModel.products) { product in
                        FavoriteCard(viewModel: FavoriteCardViewModel(product: product))
                    }
                }
                .padding()
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .background(Color.lightGray)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

struct FavoriteCard: View {
    
    @ObservedObject var viewModel: FavoriteCardViewModel
    init(viewModel: FavoriteCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.darkBg)
            .frame(width: Sizes.width * 0.45, height: Sizes.height * 0.35)
            .shadow(color: .lightGray, radius: 5)
            .overlay {
                VStack(spacing: 25) {
                    Spacer()
                    
                    if let uiImage = UIImage(data: Data(self.viewModel.product.image.data)) {
                        KFImage(source: .provider(KFImageProvider(image: uiImage)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Sizes.width * 0.3, height: Sizes.width * 0.3)
                    }
                        
                        
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(self.viewModel.product.brand)
                            .lineLimit(1)
                            .foregroundStyle(.myGray)
                        Text(self.viewModel.product.name)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundStyle(.lightTheme)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("$\(self.viewModel.product.salary, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundStyle(.first)
                    }
                    .frame(maxWidth: .infinity)
                    //.padding(.top, 15)
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

#Preview {
    FavoriteView()
}
