//
//  BookDetailsViewModel.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 17.12.21..
//

import Foundation
import CoreData

class BookDetailsViewModel: ObservableObject {
    @Published var comment: String = ""
    
    // MARK: - Intents
    func leaveComment(bookId: UUID) {
        if comment.count > 0 {
            Persistance.shared.leave(comment: comment, for: bookId)
        }
    }
    
    func rateBook(bookId: UUID, rating: Int) {
        if let userId = Persistance.currentUser?.userId {
            Persistance.shared.rate(book: bookId, with: rating, by: userId)
        }
    }
    
    func changePromotionStatus(for book: Book) {
        if let id = book.bookId {
            Persistance.shared.onPromotion(book: id, status: !book.promotion)
        }
    }
}
