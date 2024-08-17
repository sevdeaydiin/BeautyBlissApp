//
//  CustomTabView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import SwiftUI

struct CustomTabView: View {
    
    //let user: User
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var activeTab: Tab = .favorite
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                HomeView(viewModel: ProductViewModel())
                    //.background(Color.white.ignoresSafeArea())
                    .tag(Tab.home)
                    .toolbar(.hidden, for: .tabBar)
                
                Explore()
                    .tag(Tab.explore)
                    .toolbar(.hidden, for: .tabBar)
                
                Favorite()
                    //.background(Color.lightGray.ignoresSafeArea())
                    .tag(Tab.favorite)
                    .toolbar(.hidden, for: .tabBar)
                
                Text("Profile")
                    .tag(Tab.profile)
                    .toolbar(.hidden, for: .tabBar)
            }
            
            CustomTabBar()
                .background(Color.white.opacity(0.1)) // TabBar'ın arka planını saydam yap
                .padding(.top, -35)
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
