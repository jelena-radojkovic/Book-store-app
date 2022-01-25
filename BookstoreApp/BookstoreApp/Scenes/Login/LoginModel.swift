//
//  LoginModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 15.12.21..
//

import Foundation

class CurrentUser {
    var adress: String
    var name: String
    var surname: String
    var password: String
    var phoneNumber: String
    var username: String
    var userId: UUID
    var userType: String
    
    init(adress: String, phoneNumber: String, name: String, surname: String, password: String, username: String, userId: UUID, userType: String) {
        self.adress = adress
        self.phoneNumber = phoneNumber
        self.name = name
        self.surname = surname
        self.password = password
        self.username = username
        self.userId = userId
        self.userType = userType
    }
}
