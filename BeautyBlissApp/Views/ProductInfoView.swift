//
//  ProductInfoView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 18.08.2024.
//

import SwiftUI
import Kingfisher

struct ProductInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    //@Binding var isShowingProductInfo: Bool
    @ObservedObject var viewModel: HomeCardViewModel
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    //let product: Product
    
    var body: some View {
        
        VStack {
            
            Button {
                //isShowingProductInfo = false
                dismiss()
            }label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.bottom, 10)
            }
            
            ScrollView {
                if let uiImage = UIImage(data: Data(self.viewModel.product.image.data)) {
                    KFImage(source: .provider(KFImageProvider(image: uiImage)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: Sizes.width * 0.5, height: Sizes.height * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white)
                            //.shadow(color: .gray, radius: 5)
                                .frame(width: Sizes.width * 0.9, height: Sizes.height * 0.4)
                                .shadow(color: .myGray, radius: 5)
                        )
                        .padding(.top, 150)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(self.viewModel.product.brand)
                        Spacer()
                        //Text(self.viewModel.product.brand)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    HStack {
                        Text(self.viewModel.product.name)
                        Spacer()
                        Text("$\(self.viewModel.product.salary, specifier: "%.2f")")
                    }
                    .font(.headline)
                    HStack(spacing: 0) {
                        ForEach((0...4).reversed(), id: \.self) {_ in
                            Image(systemName: "star.fill")
                                .foregroundStyle(.first)
                        }
                        Spacer()
                        Text("5.0")
                            .foregroundStyle(.gray)
                        Divider()
                            .frame(width: 5, height: 20)
                            .padding(.horizontal, 10)
                        Text("528 reviews")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .font(.callout)
                    
                    HStack(spacing: 20) {
                        Circle()
                            .fill(.first)
                            .frame(width: 25, height: 25)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 35, height: 35)
                                    .shadow(radius: 2)
                            )
                        Circle()
                            .fill(Color.text)
                            .frame(width: 25, height: 25)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 33, height: 33)
                                    .shadow(radius: 0)
                            )
                        Circle()
                            .fill(Color.buttonText)
                            .frame(width: 25, height: 25)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 33, height: 33)
                                    .shadow(radius: 0)
                            )
                    }
                    .padding(.top, 20)
                    
                    Text(self.viewModel.product.productInfo!)
                        .foregroundStyle(.gray)
                        .font(.callout)
                        .lineLimit(5)
                        .padding(.vertical, 20)
                    
                }
                .padding(.top, Sizes.height * 0.2)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Text("Buy Now")
                        //.font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.myPink)
                        .cornerRadius(5)
                }
                Button {
                    favoriteViewModel.addFavorite(productId: viewModel.product.id)
                } label: {
                    Image(systemName: "heart")
                            //self.favoriteViewModel.favoriteProducts.contains(viewModel.product.id) ? )
                        .foregroundStyle(.first)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white)
                                .shadow(radius: 5)
                        )
                }
                .padding(.trailing, 5)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .onAppear {
            viewModel.fetchProductById()
        }
    }
}
