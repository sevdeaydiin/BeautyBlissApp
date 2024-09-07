//
//  HomeCard.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 7.09.2024.
//

import SwiftUI
import Kingfisher

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
