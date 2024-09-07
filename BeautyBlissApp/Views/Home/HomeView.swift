//
//  HomeView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 8.07.2024.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @State var searchProduct: String = ""
    let images = ["home", "home1", "home2"]
    
    @ObservedObject var viewModel: ProductViewModel

    @State private var selectedProduct: Product?
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                
                ToolBar()
                
                ScrollView(showsIndicators: false) {
                    
                    SearchProduct(searchProduct: $searchProduct)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack (spacing: 10){
                            ForEach(images, id: \.self) { image in
                                ZStack {
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: 150)
                                        .scrollTransition(axis: .horizontal) { content, phase in
                                            return content.offset(x: phase.value * -250)
                                        }
                                }
                                .containerRelativeFrame(.horizontal)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .contentMargins(.horizontal, 32)
                    .padding(.leading, -20)
                    .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack (spacing: 10) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                CategoryButton(category: category, isSelected: viewModel.selectedCategory == category) {
                                    viewModel.selectedCategory = category
                                    viewModel.filterProducts(by: category)
                                }
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 20)
                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid( columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.filteredProducts, id: \.id) { product in
                                NavigationLink {
                                    ProductInfoView(viewModel: HomeCardViewModel(product: product))
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    HomeCard(product: product, viewModel: HomeCardViewModel(product: product))
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.bottom, -20)
                    
                }
            }
            .ignoresSafeArea(.all)
            .padding(.horizontal, 10)
            .padding(.vertical)
        }
    }
}

struct ToolBar: View {
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.decrease")
            Spacer()
            Image("lotus")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
            Spacer()
            Image(systemName: "bag")
        }
        .padding(.top, -30)
    }
}

struct CategoryButton: View {
    
    let category: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category)
                .foregroundStyle(isSelected ? .white : .first)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(isSelected ? .first : .white)
                .cornerRadius(5)
        }
    }
}

