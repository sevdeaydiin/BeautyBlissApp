//
//  FlickerTextAnimation.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 3.08.2024.
//

import SwiftUI

struct FlickerTextAnimation: View {
    
    @State var letterColors: [Color] = Array(repeating: .black, count: "Latest Cosmetics Every Day and Bla Bla".count)
    var color: Color = .black
    @Binding var text: String
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<self.text.count, id: \.self) { index in
                Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                    .foregroundStyle(letterColors[index])
                    .shadow(color: letterColors[index] == color ? color : .gray, radius: 2)
                    //.shadow(color: letterColors[index] == color ? color : .gray, radius: 50)
                
            }
        }
        .font(.system(.largeTitle, design: .serif))
        .fontWeight(.bold)
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                changeColors()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    timer.invalidate()
                    
                    letterColors = Array(repeating: color, count: text.count)
                }
            }
        }
        
    }
    
    func changeColors() {
        for index in letterColors.indices {
            letterColors[index] = Bool.random() ? .gray.opacity(0.3) : color
        }
    }
}


