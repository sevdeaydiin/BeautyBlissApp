//
//  ContentView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 6.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if viewModel.isAuthenticated {
                if let user = viewModel.currentUser {
                    CustomTabView(user: user)
                        .environmentObject(viewModel)
                } else {
                    LoadingAnimation()
                }
            } else {
                CustomTabView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.isAuthenticated = UserDefaults.standard.object(forKey: "jsonwebtoken") != nil
        }
    }
}

#Preview {
    ContentView()
}
