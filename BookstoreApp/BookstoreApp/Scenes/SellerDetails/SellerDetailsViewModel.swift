//
//  SellerDetailsViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import Foundation
import CoreData

class SellerDetailsViewModel: ObservableObject {
    @Published var addBook: Bool = false
    
    // MARK: - Intents
    func addNewBook() {
        addBook = true
    }
}
