//
//  Profile.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 18.08.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.first)
                .frame(width: .infinity, height: Sizes.height * 0.3)
                .overlay {
                    ZStack {
                        Image("daisy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Sizes.width * 0.4, height: Sizes.width * 0.4)
                            .offset(x: -(Sizes.width * 0.45), y: 15)
                        Image("daisy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Sizes.width * 0.4, height: Sizes.width * 0.4)
                            .offset(x: -(Sizes.width * 0.3), y: -(Sizes.height * 0.13))
                        
                    }
                }
            
            HStack(spacing: 15) {
                    
                VStack(spacing: 10) {
                    Image(systemName: "bag.fill")
                        .foregroundStyle(.buttonText)
                        .font(.title)
                        .shadow(color: .myGray, radius: 3, x: 3, y: 3)
                    Text("My orders")
                        .font(.caption)
                }
                
                Divider()
                    .frame(height: 40)
                
                VStack(spacing: 10) {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.buttonText)
                        .font(.title)
                        .shadow(color: .myGray, radius: 3, x: 3, y: 3)
                    Text("Wishlist")
                        .font(.caption)
                }
                Divider()
                    .frame(height: 40)
                VStack(spacing: 10) {
                    Image(systemName: "location.fill")
                        .foregroundStyle(.buttonText)
                        .font(.title)
                        .shadow(color: .myGray, radius: 3, x: 3, y: 3)
                    Text("My address")
                        .font(.caption)
                }
                Divider()
                    .frame(height: 40)
                VStack(spacing: 10) {
                    Image(systemName: "ticket.fill")
                        .foregroundStyle(.buttonText)
                        .font(.title)
                        .shadow(color: .myGray, radius: 3, x: 5, y: 5)
                    Text("Voucher")
                        .font(.caption)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .shadow(color: .myGray, radius: 3, x: 0, y: 3)
            )
            .padding(.top, -50)
            
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(spacing: 20) {
                    Image(systemName: "person")
                        .foregroundStyle(.gray)
                        .font(.title)
                    Text("My Account")
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                    
                }
                HStack(spacing: 20) {
                    Image(systemName: "person")
                        .foregroundStyle(.gray)
                        .font(.title)
                    Text("My Account")
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                    
                }
                RouterButton(iconName: "person", text: "My Account") {
                    
                }
                RouterButton(iconName: "settings", text: "Settings") {
                    
                }
            }
            .padding()
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}

struct RouterButton: View {
    
    let iconName: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                Image(systemName: "person")
                    .foregroundStyle(.gray)
                    .font(.title)
                Text("My Account")
                    .foregroundStyle(.black)
                    
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
                
            }
        }
    }
}
