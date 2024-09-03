//
//  MyAccount.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 20.08.2024.
//

import SwiftUI
import Kingfisher

struct MyAccount: View {
    
    //@EnvironmentObject var viewModel: AuthViewModel
    @State var name: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var phoneNo: String = ""
    
    var body: some View {
        VStack {
            
            //KFImage(URL("\(NetworkConstants.baseURL)"))
            
            //Image(systemName: "person")
            //    .resizable()
            //    .aspectRatio(contentMode: .fill)
            //    .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 15) {
                Divider().frame(height: 10)
                HStack {
                    Text(LocaleKeys.Account.name.rawValue.locale())
                        .fontWeight(.bold)
                    Spacer(minLength: 90)
                    TextField("", text: $name)
                }
                //.frame(maxWidth: .infinity, alignment: .center)
                Divider().frame(height: 10)
                HStack(spacing: 60) {
                    Text(LocaleKeys.Account.lastname.rawValue.locale())
                        .fontWeight(.bold)
                    
                    TextField("", text: $lastname)
                }
                Divider().frame(height: 10)
                HStack(spacing: 70) {
                    Text(LocaleKeys.Onboarding.email.rawValue.locale())
                        .fontWeight(.bold)
                    TextField("", text: $email)
                }
                Divider().frame(height: 10)
                HStack {
                    Text(LocaleKeys.Account.phoneNo.rawValue.locale())
                        .fontWeight(.bold)
                    TextField("", text: $phoneNo)
                }
                Divider().frame(height: 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 50)
            .padding(.top, 50)
            
            Button {
                //self.viewModel.login(email: email, password: password)
            } label: {
                Text(LocalizedStringKey("save"))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.buttonText)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.first)
            .cornerRadius(5)
            .padding(.horizontal, 50)
            .padding(.top, 30)
            
            Button {
                
            } label: {
                Text("Hesabımı Kapat")
                    .foregroundStyle(.first)
                    .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    MyAccount()
}
