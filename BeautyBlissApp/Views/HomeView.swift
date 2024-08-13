//
//  HomeView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 8.07.2024.
//

import SwiftUI

struct HomeView: View {

    @State var searchProduct: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            ToolBar()
            
            SearchProduct(searchProduct: $searchProduct)
            
            
            
            Spacer()
        }
        .ignoresSafeArea(.all)
        .padding()
    }
}



#Preview {
    HomeView()
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
    }
}

struct SearchProduct: View {
    
    @Binding var searchProduct: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search product", text: $searchProduct)
            }
            .padding()
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
