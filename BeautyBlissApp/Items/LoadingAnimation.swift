//
//  LoadingAnimation.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 7.09.2024.
//

import SwiftUI

struct LoadingAnimation: View {
    
    @State var start = false
    
    var body: some View {
        ZStack {
            Text(LocaleKeys.Onboarding.loading.rawValue.locale())
                .font(.largeTitle.bold())
                .foregroundStyle(.black)
            
            Text(LocaleKeys.Onboarding.loading.rawValue.locale())
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
            
                .frame(width: 200, height: 50)
                .background(.black)
                .mask {
                    Circle()
                        .frame(width: 40, height: 40)
                        .offset(x: start ? -60 : 60)
                }
            
            Circle().stroke(.black, lineWidth: 5)
                .frame(width: 40, height: 40)
                .offset(x: start ? -60 : 60)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)
                .repeatForever(autoreverses: true)) {
                    start = true
                }
        }
    }
}

#Preview {
    LoadingAnimation()
}
