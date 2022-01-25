//
//  AddBookViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 17.1.22..
//

import Foundation
import SwiftUI

class AddBookViewModel: ObservableObject {
    @Published var bookName = ""
    @Published var author = ""
    @Published var description = ""
    @Published var yearOfPublishing = ""
    @Published var numPages = ""
    
    // MARK: - Intents
    func add(image: UIImage) -> String {
        let result = ImageManager.shared.saveImage(image: image)
        if !result.0 {
            fatalError("Image is not saved")
        } else {
            return result.1!
        }
    }
    
    func addBook(imageUrl: String) {
        Persistance.shared.addBook(bookName: self.bookName,
                                   author: self.author,
                                   description: self.description,
                                   imageUrl: imageUrl,
                                   numPages: Int(self.numPages) ?? -1,
                                   publishedYear: Int(yearOfPublishing) ?? -1)
        emptyOutAllFields()
    }
    
    private func emptyOutAllFields() {
        bookName = ""
        author = ""
        description = ""
        yearOfPublishing = ""
        numPages = ""
    }
}
