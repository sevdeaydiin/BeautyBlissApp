//
//  ExploreView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 18.08.2024.
//

import SwiftUI

struct ExploreView: View {
    
    @State var searchProduct = ""
    @State var isEditing = false
    @ObservedObject var viewModel = ExploreViewModel()
    
    var products: [Product] {
        return isEditing ? viewModel.products : viewModel.filteredProducts(searchProduct)
    }
    
    var body: some View {
        VStack {
            
            SearchProduct(searchProduct: $searchProduct, isEditing: $isEditing)
            
            if isEditing {
                SearchedProductView(searchProduct: $searchProduct, isEditing: $isEditing)
            } else {
                ForEach(products) { product in
                    HomeCard(product: product, viewModel: HomeCardViewModel(product: product))
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ExploreView()
}
