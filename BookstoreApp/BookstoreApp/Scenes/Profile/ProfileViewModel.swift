//
//  ProfileViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 15.12.21..
//

import Foundation
import SwiftUI
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var username = Persistance.currentUser?.username ?? "X"
    @Published var adress = Persistance.currentUser?.adress ?? "X"
    @Published var phoneNumber = Persistance.currentUser?.phoneNumber ?? "X"
    @Published var name = Persistance.currentUser?.name ?? "X"
    @Published var surname = Persistance.currentUser?.surname ?? "X"
    
    @Published var message: String = ""
    @Published var color: Color = .clear
    @Published var message1: String = ""
    @Published var color1: Color = .clear
    @Published var passwordChanged = false
    @Published var logout = false
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var newPasswordCheck = ""
    
    // MARK: - Intents
    func updateInfo() {
        if let password = Persistance.currentUser?.password, let id = Persistance.currentUser?.userId,
           let type = Persistance.currentUser?.userType {
            let result = Persistance.shared.updateInfo(user: CurrentUser(adress: adress,
                                                                         phoneNumber: phoneNumber,
                                                                         name: name,
                                                                         surname: surname,
                                                                         password: password,
                                                                         username: username,
                                                                         userId: id,
                                                                         userType: type))
            if let result = result {
                message1 = result
                color1 = .red
            } else {
                message1 = "Successfully updated infos"
                color1 = .green
            }
        } else {
            message1 = "Error while reading user data"
            color1 = .red
        }
    }
    
    func changePassword() {
        if let currentPassword = Persistance.currentUser?.password {
            if oldPassword != currentPassword ||
                newPassword != newPasswordCheck {
                message = "Passwords don't match!"
                color = .red
            } else {
                // change in db
                let result = Persistance.shared.change(password: newPassword, username: username)
                if let result = result {
                    message = result
                    color = .red
                } else {
                    message = "Succesfully changed password"
                    color = .green
                    oldPassword = ""
                    newPassword = ""
                    newPasswordCheck = ""
                }
                passwordChanged = true
            }
        }
    }
    
    func userLogout() {
        LoginViewModel.currentUser = nil
        logout = true
    }
}
