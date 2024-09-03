//
//  LoginView.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 4.08.2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var email: String = "emily.cooper@gmail.com"
    @State var password: String = "123456789"
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 10) {
                Image("lotus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(LocaleKeys.Onboarding.welcome.rawValue.locale())
                    .font(.system(.largeTitle, design: .serif))
                    .fontWeight(.bold)
                    .padding(.bottom, 50)
                
                NavigationLink {
                    //SignUpView().navigationBarBackButtonHidden()
                } label: {
                    Text(LocaleKeys.Onboarding.member.rawValue.locale())
                        .font(.footnote)
                        .foregroundStyle(Color.gray)
                        .fontWeight(.light) +
                    Text(LocaleKeys.Onboarding.join.rawValue.locale())
                        .font(.footnote)
                        .foregroundStyle(Color.first)
                }
                
                CircleSocialButton()
                
                HorizontalLine()
                
                CustomTextField(placeholderText: LocaleKeys.Onboarding.email.rawValue.locale(), text: $email)
                    .onTextChange { oldValue, newValue in
                        print(newValue)
                    }
                    .padding(.top, 30)
                CustomTextField(placeholderText: LocaleKeys.Onboarding.password.rawValue.locale(), text: $password)
                
                Button {
                    self.viewModel.login(email: email, password: password)
                } label: {
                    Text(LocalizedStringKey("login"))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.buttonText)
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.first)
                .cornerRadius(5)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
        }
        
    }
}

private struct HorizontalLine: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 0.5)
            Text("OR")
            Rectangle()
                .frame(height: 0.5)
        }
        .foregroundColor(.gray)
        .padding(.horizontal, 24)
    }
}

private struct CircleSocialButton: View {
    var body: some View {
        HStack(spacing: 20) {
            Button {
                print("facebook")
            } label: {
                Image("facebook")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Button {
                print("google")
            } label: {
                Image("google")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }.padding()
    }
}
