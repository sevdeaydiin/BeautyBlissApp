//
//  OnboardingView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 3.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var gradient = [Color.lightPink, Color.lightPink, Color.first.opacity(0.4)]
    @State var text1 = "Latest"
    @State var text2 = "Cosmetics"
    @State var text3 = "Every Day"
    
    var body: some View {
        ZStack {
            LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 20) {
                Spacer()
                Image("lotus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                VStack(spacing: 10) {
                    FlickerTextAnimation(text: $text1)
                    FlickerTextAnimation(text: $text2)
                    FlickerTextAnimation(text: $text3)
                }
                
                //Text("Latest\nCosmetics\nEvery Day")
                //    .font(.largeTitle)
                //    .fontWeight(.bold)
                //    .multilineTextAlignment(.center)
                //    .foregroundStyle(Color.darkBg)
                
                Text("Various types of make up latest and trendy especially for you")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontWeight(.light)
                    .lineLimit(3)
                    .foregroundStyle(Color.gray)
                    
                
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
    OnboardingView()
}

