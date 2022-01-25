//
//  RegisterModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import Foundation

enum UserType: String {
    case seller = "admin"
    case customer = "user"
}

struct RegisterModel {
    var name = ""
    var surname = ""
    var phoneNumber = ""
    var adress = ""
    var username = ""
    var password = ""
    var passwordCheck = ""
    var userType = UserType.customer
}
