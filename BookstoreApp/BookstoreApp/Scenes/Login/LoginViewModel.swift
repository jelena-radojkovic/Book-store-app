//
//  LoginViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import Foundation
import CoreData
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isAuthorized: Bool = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var message: String = ""
    @Published var color: Color = .clear
    static var currentUser: CurrentUser?

    // MARK: - Intents
    func login() {
        let result = Persistance.shared.login(username: username, password: password)
        isAuthorized = result.0
        if !isAuthorized {
            message = result.1
            color = .red
        } else {
            message = ""
            color = .clear
        }
    }
}
