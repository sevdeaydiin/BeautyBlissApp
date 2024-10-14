//
//  FavoriteCard.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 14.10.2024.
//

import SwiftUI
import Kingfisher

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
