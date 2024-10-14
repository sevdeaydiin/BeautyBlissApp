//
//  SearchedProductView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 14.10.2024.
//

import SwiftUI

struct SearchedProductView: View {
    
    @Binding var searchProduct: String
    @Binding var isEditing: Bool
    @ObservedObject var viewModel = ExploreViewModel()
    
    var products: [Product] {
        return isEditing ? viewModel.products : viewModel.filteredProducts(searchProduct)
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(products) { product in
                    Text(product.name)
                        .font(.subheadline)
                        .foregroundStyle(searchProduct.isEmpty ? .gray : .black)
                        .padding(5)
                }
            }
        }
        .padding(.top, Sizes.height * 0.01)
    }
}
