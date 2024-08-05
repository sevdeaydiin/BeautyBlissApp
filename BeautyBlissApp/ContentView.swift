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
                } else {
                    Text("Loading user data...")
                }
            } else {
                OnboardingView()
            }
        }
        .onAppear {
            print("isAuthenticated: \(viewModel.isAuthenticated)")
            if let user = viewModel.currentUser {
                print("Current User: \(user)")
            } else {
                print("No current user")
            }
            viewModel.isAuthenticated = UserDefaults.standard.object(forKey: "jsonwebtoken") != nil
        }
    }
}


#Preview {
    ContentView()
}
