//
//  ProfileView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 15.12.21..
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var viewModel = ProfileViewModel()
    private let emptyString = ""
    @State var changePassword = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Change your information:").foregroundColor(.accentColor)
                Group {
                    VStack {
                        Text("Name")
                            .font(.footnote)
                        TextField("Name", text: $viewModel.name)
                            .border(Color.gray)
                    }
                    VStack {
                        Text("Surname")
                            .font(.footnote)
                        TextField("Adress", text: $viewModel.surname)
                            .border(Color.gray)
                    }
                    VStack {
                        Text("Phone number")
                            .font(.footnote)
                        TextField("Phone number", text: $viewModel.phoneNumber)
                            .border(Color.gray)
                    }
                    VStack {
                        Text("Adress")
                            .font(.footnote)
                        TextField("Adress", text: $viewModel.adress)
                            .border(Color.gray)
                    }
                    
                    VStack {
                        Text("Username")
                            .font(.footnote)
                        TextField("Username", text: $viewModel.username)
                            .border(Color.gray)
                            .disabled(true)
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
                .padding(.trailing, 15)
                .padding(.leading, 15)
                
                Text(viewModel.message1)
                    .foregroundColor(viewModel.color1)
                
                Spacer()
                
                Button("Update information") {
                    viewModel.updateInfo()
                }
                .buttonStyle(PurpleishButton())
                
                Button("Change password") {
                    changePassword = true
                }
                .buttonStyle(BlueishButton())
                
                Button("Log out") {
                    viewModel.userLogout()
                }
                .buttonStyle(BlueishButton())
                
                NavigationLink(isActive: $viewModel.logout) {
                    LoginView()
                } label: {
                    Text(emptyString)
                }
            }
            .onDisappear(perform: {
                viewModel.message = ""
                viewModel.message1 = ""
                viewModel.color = .clear
                viewModel.color1 = .clear
            })
                .sheet(isPresented: $changePassword) {
                    changePassword = false
                    viewModel.message = ""
                    viewModel.color = .clear
                    print("dismissed")
                } content: {
                    changePasswordView
                }
        }.navigationBarBackButtonHidden(true)
    }
    
    var changePasswordView: some View {
        VStack {
            Group {
                PasswordRevealTextField(placeholder: "Old password",
                                        text: $viewModel.oldPassword,
                                        showPasswordIcon: Image(systemName: "eye"),
                                        hidePasswordIcon: Image(systemName: "eye.slash"),
                                        onCommit: {})
                PasswordRevealTextField(placeholder: "New password",
                                        text: $viewModel.newPassword,
                                        showPasswordIcon: Image(systemName: "eye"),
                                        hidePasswordIcon: Image(systemName: "eye.slash"),
                                        onCommit: {})
                PasswordRevealTextField(placeholder: "New password",
                                        text: $viewModel.newPasswordCheck,
                                        showPasswordIcon: Image(systemName: "eye"),
                                        hidePasswordIcon: Image(systemName: "eye.slash"),
                                        onCommit: {})
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.gray)
            .background(Color.white)
            .padding(5)
            .padding(.trailing, 15)
            .padding(.leading, 15)
            Text(viewModel.message)
                .font(.footnote)
                .foregroundColor(viewModel.color)
            
            Button("Change password") {
                viewModel.changePassword()
            }.buttonStyle(BlueishButton())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
