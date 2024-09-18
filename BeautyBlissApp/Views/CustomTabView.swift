//
//  CustomTabView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import SwiftUI

struct CustomTabView: View {
    
    let user: User?
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var activeTab: Tab = .home
    @Namespace private var animation
    @State private var isShowingProductInfo = false
    @State private var isPage: Bool = false
    @State private var page: Int = 0
    
    init(user: User? = nil) {
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TabView(selection: $activeTab) {
                    HomeView(viewModel: ProductViewModel())
                    //.background(Color.white.ignoresSafeArea())
                        .tag(Tab.home)
                        .toolbar(.hidden, for: .tabBar)
                    
                    ExploreView()
                        .tag(Tab.explore)
                        .toolbar(.hidden, for: .tabBar)
                    
                    FavoriteView()
                    //.background(Color.lightGray.ignoresSafeArea())
                        .tag(Tab.favorite)
                        .toolbar(.hidden, for: .tabBar)
                    
                    //Button {
                    //    isPage = true
                    //    page = 1
                    //    isShowingProductInfo = true
                    //} label: {
                    
                    if viewModel.isAuthenticated {
                        if let user = viewModel.currentUser {
                            ProfileView(user: user, isShow: $isShowingProductInfo)
                                .environmentObject(viewModel)
                                .tag(Tab.profile)
                                .toolbar(.hidden, for: .tabBar)
                        }
                    } else {
                        LoginView()
                            .tag(Tab.profile)
                            .toolbar(.hidden, for: .tabBar)
                    }  
                }
                
                if !isShowingProductInfo {
                    CustomTabBar()
                        .background(Color.white.opacity(0.1))
                        .padding(.top, -35)
                }
            }
            .navigationDestination(isPresented: $isPage) {
                switch page {
                case 1:
                    ProfileView(user: user!, isShow: $isShowingProductInfo)
                default:
                    RegisterView()
                }
            }
        }
        
    }
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color.first, _ inactiveTint: Color = Color.gray.opacity(0.6)) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .background(content: {
            Rectangle()
                .fill(.darkBg)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.5), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem:View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundStyle(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 60 : 35, height: activeTab == tab ? 60 : 35)
                .background{
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundStyle(activeTab == tab ? tint : .gray.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            activeTab = tab
        }
    }
}

#Preview {
    CustomTabView()
}
