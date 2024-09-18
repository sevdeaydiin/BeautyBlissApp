//
//  ProfileView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 18.08.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isPage: Bool = false
    @State var page: Int = 0
    @Binding var isShow: Bool
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var isCurrentUser: Bool {
        return viewModel.user.isCurrentUser ?? false
    }
    
    let user: User
    
    init(user: User, isShow: Binding<Bool>) {
        self.user = user
        self._isShow = isShow
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.first)
                    //.frame(width: .infinity - 10, height: Sizes.height * 0.37)
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
                            
                            VStack(spacing: 20) {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                
                                Text(viewModel.user.name)
                                    .font(.system(.title, design: .serif))
                                    .fontWeight(.bold)
                                    
                            }.foregroundStyle(.white)
                        }
                    }
                
                NavigationStack {
                    HStack(spacing: 15) {
                            
                        HorizontalCardView(iconName: "bag.fill", text: LocaleKeys.Profile.myOrders.rawValue.locale()) {
                            isPage = true
                            page = 1
                        }
                        
                        Divider()
                            .frame(height: 40)
                        
                        HorizontalCardView(iconName: "heart.fill", text: LocaleKeys.Profile.wishlist.rawValue.locale()) {
                            isShow = true
                            isPage = true
                            page = 2
                        }
        
                        Divider()
                            .frame(height: 40)
                        
                        HorizontalCardView(iconName: "location.fill", text: LocaleKeys.Profile.myAddress.rawValue.locale()) {
                            isPage = true
                            page = 3
                        }

                        Divider()
                            .frame(height: 40)
                        HorizontalCardView(iconName: "ticket.fill", text: LocaleKeys.Profile.voucher.rawValue.locale()) {
                            isPage = true
                            page = 4
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

                        RouterButton(iconName: "person", text: LocaleKeys.Profile.myAccount.rawValue.locale()) {
                            isPage = true
                            page = 5
                        }
                                    
                            RouterButton(iconName: "gearshape", text: LocaleKeys.Profile.settings.rawValue.locale()) {
                                isPage = true
                                page = 6
                            }
                        
                            RouterButton(iconName: "questionmark.circle", text: LocaleKeys.Profile.help.rawValue.locale()) {
                                isPage = true
                                //page = 3
                            }
                        
                        
                        RouterButton(iconName: "bubble.left", text: LocaleKeys.Profile.contactUs.rawValue.locale()) {
                            page = 8
                            
                        }
                        
                        RouterButton(iconName: "rectangle.portrait.and.arrow.right", text: LocaleKeys.Profile.logOut.rawValue.locale()) {
                                self.authViewModel.logout()
                        }
                    }
                    .padding(.vertical, 50)
                    .padding(.horizontal, 60)
                    .navigationDestination(isPresented: $isPage) {
                        switch page {
                        case 1:
                            MyOrders()
                                //.navigationBarBackButtonHidden()
                        case 2:
                            FavoriteView().navigationBarBackButtonHidden()
                        case 5:
                            MyAccount(user: $viewModel.user)
                                .navigationBarBackButtonHidden()
                        case 6:
                            Settings()
                                //.navigationBarBackButtonHidden()
                            
                        
                        default:
                            OnboardingView().navigationBarBackButtonHidden()
                        }
                    }
                    
                }
                
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

struct RouterButton: View {
    
    let iconName: String
    let text: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                Image(systemName: iconName)
                    .foregroundStyle(.gray)
                    .font(.title)
                Text(text)
                    .foregroundStyle(.black)
                
                    
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
                
            }
        }
    }
}



struct HorizontalCardView: View {
    
    let iconName: String
    let text: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: iconName)
                    .foregroundStyle(.buttonText)
                    .font(.title)
                    .shadow(color: .myGray, radius: 3, x: 3, y: 3)
                Text(text)
                    .font(.caption)
                    .foregroundStyle(.black)
            }
        }
        
    }
}
