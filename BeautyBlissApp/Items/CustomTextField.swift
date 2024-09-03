//
//  CustomTextField.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 8.07.2024.
//

import SwiftUI

struct CustomTextField: View {
    
    let placeholderText: LocalizedStringKey
    @Binding private var text: String
    let animation: Animation = .spring(response: 0.1, dampingFraction: 0.6)
    @State private var placeholderOffset: CGFloat
    @State private var scaleEffectValue: CGFloat
    
    private var onTextAction: ((_ oldValue: String, _ newValue: String) -> ())?
    
    init(placeholderText: LocalizedStringKey, text: Binding<String>, placeholderOffset: CGFloat = 0, scaleEffectValue: CGFloat = 1, onTextAction: ((_: String, _: String) -> Void)? = nil) {
        self.placeholderText = placeholderText
        self._text = text
        self.placeholderOffset = placeholderOffset
        self.scaleEffectValue = scaleEffectValue
        self.onTextAction = onTextAction
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholderText)
                .foregroundStyle($text.wrappedValue.isEmpty ? Color.mySecondary : .gray)
                .font($text.wrappedValue.isEmpty ? .headline : .caption)
                .offset(y: placeholderOffset)
                .scaleEffect(scaleEffectValue, anchor: .leading)
                .padding(.horizontal, 10)
            
            TextField("", text: $text)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(Color.lightTheme)
                .padding(.horizontal, 10)
        }
        .padding(.vertical, 14)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1)
        }
        .onChange(of: text) { oldValue, newValue in
            withAnimation(animation) {
                placeholderOffset = $text.wrappedValue.isEmpty ? 0 : -17
                scaleEffectValue = $text.wrappedValue.isEmpty ? 1 : 0.75
                
            }
            onTextAction?(oldValue, newValue)
        }
        .padding(.bottom, 10)
    }
}


extension CustomTextField {
    public func onTextChange(_ onTextAction: @escaping ((_ oldValue: String, _ newValue: String) -> ())) -> Self {
        var view = self
        view.onTextAction = onTextAction
        return view
    }
}
