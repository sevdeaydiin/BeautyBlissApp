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

struct HomeCard: View {
    
    let product: Product
    @ObservedObject var viewModel: HomeCardViewModel
    
    var body: some View {

        RoundedRectangle(cornerRadius: 5)
            .fill(Color.darkBg)
            .frame(width: Sizes.width * 0.45, height: Sizes.height * 0.25)
            .shadow(color: .myGray.opacity(0.6), radius: 2)
            .overlay {
                VStack(spacing: 25) {
                    Spacer()
                    if let uiImage = UIImage(data: Data(self.viewModel.product.image.data)) {
                        KFImage(source: .provider(KFImageProvider(image: uiImage)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Sizes.width * 0.2, height: Sizes.width * 0.2)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.brand)
                            .font(.caption)
                            .lineLimit(1)
                            .foregroundStyle(.myGray)
                        Text(product.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(2)
                            .foregroundStyle(.lightTheme)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("$\(product.salary, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundStyle(.first)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 2)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
            }
            .overlay(
                Text("%35")
                    .foregroundStyle(.white)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .position(x: 30, y: 30)
                    .background(
                        Circle()
                        //.font(.title2)
                            .foregroundStyle(.myPink)
                            .frame(width: 30, height: 30)
                            .position(x: 30, y: 30)
                        
                    )
            )
            .padding(.horizontal, 5)
    }
}

