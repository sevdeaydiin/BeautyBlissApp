//
//  SplashView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 6.07.2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var gradient = [Color.background, Color.background, Color.first.opacity(0.4)]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text("Latest\nCosmetics\nEvery Day")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.lightText)
                
                Text("Various tyoes of make up latest and trendy especially for you")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                
                Image("beauty")
                    .resizable()
                    .scaledToFill()
                    .shadow(color: .gray, radius: 5, x: 10, y: 15)
                    .frame(width: 250, height: 250)
                    .padding(.vertical, 50)
                
                Button {
                    
                } label: {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.ultraThinMaterial)
                        .overlay(
                            Circle()
                                .frame(width: 80, height: 80)
                                .foregroundStyle(Color.first)
                                .overlay(
                                    Image(systemName: "chevron.right")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.secondary)
                                )
                        )
                }
                
                Spacer()
            }.padding(.horizontal, 20)
                .padding(.top, 30)
        }.ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
