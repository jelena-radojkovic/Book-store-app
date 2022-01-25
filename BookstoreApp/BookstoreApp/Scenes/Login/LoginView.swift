//
//  LoginView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import SwiftUI
import CoreData

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    private let emptyString = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("bookstore3").resizable().edgesIgnoringSafeArea(.all)
                VStack {
                    Group {
                        TextField("Username", text: $viewModel.username)
                        PasswordRevealTextField(placeholder: "Password",
                                                text: $viewModel.password,
                                                showPasswordIcon: Image(systemName: "eye"),
                                                hidePasswordIcon: Image(systemName: "eye.slash"),
                                                onCommit: {})
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.white)
                    .background(Color.white)
                    .padding(5)
                    .padding(.trailing, 15)
                    .padding(.leading, 15)
                    
                    Text(viewModel.message)
                        .font(.headline)
                        .foregroundColor(viewModel.color)
                    
                    Button("Login") {
                        viewModel.login()
                    }.buttonStyle(BlueButton())
                    Spacer()
                    HStack {
                        Text("Don't have an account?")
                        NavigationLink {
                            RegisterView()
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        } label: {
                            Text("Register!")
                        }
                    }
                    .font(.footnote)
                    
                    NavigationLink(isActive: $viewModel.isAuthorized) {
                        if Persistance.userType == "admin" {
                            SellerDetailsView()
                        } else if Persistance.userType == "user" {
                            BuyerDetailsListView()
                        }
                    } label: {
                        Text(emptyString)
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
