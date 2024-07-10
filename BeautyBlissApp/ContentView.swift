//
//  ContentView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 6.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Tab = .home
    @Namespace private var animation
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                HomeView()
                    .tag(Tab.home)
                    .toolbar(.hidden, for: .tabBar)
                
                Text("Services")
                    .tag(Tab.services)
                    .toolbar(.hidden, for: .tabBar)
                
                Text("Partners")
                    .tag(Tab.partners)
                    .toolbar(.hidden, for: .tabBar)
                
                Text("Activity")
                    .tag(Tab.activity)
                    .toolbar(.hidden, for: .tabBar)
            }
            
            CustomTabBar()
            
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
        }.frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                activeTab = tab
            }
    }
}

#Preview {
    ContentView()
}
