//
//  AdminBooksViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 17.1.22..
//

import Foundation

class AdminBooksViewModel: ObservableObject {
    @Published var bookName = ""
    @Published var author = ""
    @Published var books = Persistance.shared.getAllBooks()
    
    // MARK: - Intents
    func filter() {
        books = Persistance.shared.getAllBooks()
        if bookName != "" && author != "" {
            books = books.filter { $0.author == author }
            books = books.filter { $0.name == bookName }
            return
        }
        if bookName != "" && author == "" {
            books = books.filter { $0.name == bookName}
            return
        }
        if bookName == "" && author != "" {
            books = books.filter { $0.author == author}
            return
        }
    }
    
    func simpleFilter(name: String) -> [Book] {
        Persistance.shared.getAllBooks().filter { $0.name!.contains(name) }
    }
    
    func changePromotionStatus(for book: Book) {
        if let id = book.bookId {
            Persistance.shared.onPromotion(book: id, status: !book.promotion)
            books = Persistance.shared.getAllBooks()
        }
    }
}
