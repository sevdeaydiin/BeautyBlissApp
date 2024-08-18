//
//  Explore.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import SwiftUI

struct ExploreView: View {
    @State var searchProduct = ""
    var body: some View {
        VStack {
            SearchProduct(searchProduct: $searchProduct)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ExploreView()
}
