//
//  RecommendedBooksView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 5.1.22..
//

import SwiftUI

struct RecommendedBooksView: View {
    var body: some View {
        List {
            ForEach(Persistance.shared.getRecommendedBooks(), id: \.self) { book in
                HStack {
                    VStack {
                        Text("From user: ")
                            .font(Font.footnote)
                        Text("\(Persistance.shared.getUsername(for: book.fromUser))")
                            .font(Font.footnote)
                    }
                    Divider()
                        .frame(height: 220)
                    VStack {
                        Text("\(Persistance.shared.getBookDetails(for: book.bookId)?.author ?? "err")")
                            .frame(width: 150, height: 30, alignment: .center)
                        ImageManager.shared.getImage(imageUrl: Persistance.shared.getBookDetails(for: book.bookId)?.imageUrl ?? "X")
                            .resizable()
                            .frame(width: 50 , height: 75)
                            .padding()
                        Text("\(Persistance.shared.getBookDetails(for: book.bookId)?.name ?? "err")")
                        
                    }.padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .listStyle(PlainListStyle())
    }
}

struct RecommendedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedBooksView()
    }
}
