//
//  MyAccount.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 20.08.2024.
//

import SwiftUI
import Kingfisher

struct MyAccount: View {
    
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    @State var name: String = ""
    @State var lastname: String = ""
    //@State var email: String = ""
    @State var phoneNo: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._name = State(initialValue: self._user.name.wrappedValue)
        self._lastname = State(initialValue: self._user.lastname.wrappedValue)
        self._phoneNo = State(initialValue: self._user.phoneNo.wrappedValue)
    }
    
    var body: some View {
        VStack {
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 20)
            
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
                HStack(spacing: 55) {
                    Text(LocaleKeys.Account.lastname.rawValue.locale())
                        .fontWeight(.bold)
                    
                    TextField("", text: $lastname)
                }
                Divider().frame(height: 10)
                HStack(spacing: 90) {
                    Text(LocaleKeys.Onboarding.email.rawValue.locale())
                        .fontWeight(.bold)
                    Text(self.viewModel.user.email)
                        .lineLimit(1)
                        
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
            .padding(.horizontal, 20)
            .padding(.top, 50)
            
            Button {
                self.viewModel.uploadUserData(name: name, lastname: lastname, phoneNo: phoneNo)
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
        .onReceive(viewModel.$uploadComplete) { complete in
            if complete {
                self.user.name = viewModel.user.name
                self.user.lastname = viewModel.user.lastname
                self.user.phoneNo = viewModel.user.phoneNo
            }
        }
    }
}
