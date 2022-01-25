//
//  RecommendABookView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 10.1.22..
//

import SwiftUI

struct RecommendABookView: View {
    let bookId: UUID?
    let usernames = Persistance.shared.getAllUsernames()
    @State var toUser = "W"
    @State var isActive = false
    
    var body: some View {
        Picker("To user..", selection: $toUser) {
            ForEach(usernames, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.wheel)
        
        Button("Recommend") {
            if recommend(user: self.toUser) {
                self.isActive = true
            }
        }.buttonStyle(PurpleishButton())
            .padding()
        
        NavigationLink(isActive: $isActive) {
            if let book = Persistance.shared.getBookDetails(for: bookId) {
                BookDetailsView(book: book, rating: Persistance.shared.getRatingByCurrentUser(for: bookId) ?? 0)
            }
        } label: {
            EmptyView()
        }
            .padding()
            .navigationBarTitle("Choose user", displayMode: .inline)
    }
    
    func recommend(user: String?) -> Bool {
        if let user = user, let bookId = self.bookId {
            Persistance.shared.recommend(book: bookId, to: user)
            return true
        }
        return false
    }
    
}

struct RecommendABookView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendABookView(bookId: UUID())
    }
}
