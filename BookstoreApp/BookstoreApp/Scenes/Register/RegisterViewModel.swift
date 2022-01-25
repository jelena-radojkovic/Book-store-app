//
//  RegisterViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import Foundation
import SwiftUI
import CoreData

class RegisterViewModel: ObservableObject {
    @Published var model = RegisterModel()
    @Published var message = ""
    @Published var color: Color = .clear
    
    // MARK: - Intentions
    func register() {
        if model.name.count>0 && model.surname.count>0 && model.phoneNumber.count>0 && model.adress.count>0 &&
            model.username.count>0 && model.password.count>0 && model.password == model.passwordCheck {
            if validate(value: model.phoneNumber) {
                addUser()
                emptyOutRegisterFields()
                message = "Succesfull registration"
                color = .green
            } else {
                model.password = ""; model.passwordCheck = ""
                message = "Type phone number as xxx-xxx-xxxx"
                color = .red
            }
        } else {
            emptyOutRegisterFields()
            message = "All fields must be completed, and passwords must match"
            color = .red
        }
    }
    
    private func addUser() {
        let user = CurrentUser(adress: model.adress,
                               phoneNumber: model.phoneNumber,
                               name: model.name,
                               surname: model.surname,
                               password: model.password,
                               username: model.username,
                               userId: UUID(),
                               userType: model.userType.rawValue)
        Persistance.shared.register(user)
    }
    
    private func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    private func emptyOutRegisterFields() {
        model.name = ""
        model.surname = ""
        model.phoneNumber = ""
        model.adress = ""
        model.username = ""
        model.password = ""
        model.passwordCheck = ""
    }
}
