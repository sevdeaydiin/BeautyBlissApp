//
//  SearchProduct.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import SwiftUI

struct SearchProduct: View {
    
    @Binding var searchProduct: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search product", text: $searchProduct)
                
                if isEditing {
                    Button {
                        isEditing = false
                        searchProduct = ""
                        UIApplication.shared.endEditing()
                    } label: {
                        Image(systemName: "multiply")
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
            .onTapGesture {
                isEditing = true
            }
            .background(Color.lightGray)
            .cornerRadius(5)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.first)
                .frame(width: 50)
                .overlay(Image("filter")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding(.horizontal, 5)
    }
}
