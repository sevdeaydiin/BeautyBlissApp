//
//  TextView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 29.09.2024.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        VStack {
            Text("Favorite list is empty.")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, Sizes.height / 7)
            Spacer()
        }
    }
}

#Preview {
    TextView()
}
