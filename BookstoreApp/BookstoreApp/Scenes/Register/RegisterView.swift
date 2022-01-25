//
//  Register.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("bookstore3").resizable().edgesIgnoringSafeArea(.all)
                VStack {
                    Group {
                        Picker(selection: $viewModel.model.userType) {
                            Text("Seller").tag(UserType.seller)
                            Text("Customer").tag(UserType.customer)
                        } label: {
                            Text("User type:")
                        }.pickerStyle(SegmentedPickerStyle())
                        TextField("Name", text: $viewModel.model.name)
                        TextField("Surname", text: $viewModel.model.surname)
                        TextField("Phone number", text: $viewModel.model.phoneNumber)
                        TextField("Adress", text: $viewModel.model.adress)
                        TextField("Username", text: $viewModel.model.username)
                        PasswordRevealTextField(placeholder: "Password",
                                                text: $viewModel.model.password,
                                                showPasswordIcon: Image(systemName: "eye"),
                                                hidePasswordIcon: Image(systemName: "eye.slash"),
                                                onCommit: {})
                            .padding(.top, 3)
                            .padding(.bottom,3)
                        PasswordRevealTextField(placeholder: "Password",
                                                text: $viewModel.model.passwordCheck,
                                                showPasswordIcon: Image(systemName: "eye"),
                                                hidePasswordIcon: Image(systemName: "eye.slash"),
                                                onCommit: {})
                            .padding(.top, 3)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   // .padding(5)
                    .padding(.trailing, 15)
                    .padding(.leading, 15)
                    
                    Text(viewModel.message)
                        .font(.headline)
                        .foregroundColor(viewModel.color)
                  
                    Button("Register") {
                        viewModel.register()
                    }.buttonStyle(BlueButton())
                    
                    Spacer()
                    
                    HStack {
                        Text("Have an account?")
                        NavigationLink {
                            LoginView()
                                .navigationBarHidden(true)
                        } label: {
                            Text("Login instead!")
                        }
                    }
                    .font(.footnote)
                }
            }
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
