//
//  CommentsView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 21.12.21..
//

import SwiftUI

struct CommentsView: View {
    var bookId: UUID
    
    var body: some View {
            List {
                ForEach(Persistance.shared.getComments(for: bookId), id: \.self) { comment in
                    HStack {
                        VStack {
                            Text("From user: ")
                            Text(comment.username)
                        }
                        .font(Font.footnote)
                        
                        Divider()
                            .frame(height: 70)
                        
                        VStack {
                            Text(comment.comment ?? "-")
                                .italic()
                            if let rating = comment.rating {
                                StaticStarRatingView(rating: rating)
                            }
                        }.padding()
                    }
                }
            }
            .navigationBarTitle("Comments")
            .listStyle(PlainListStyle())
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(bookId: UUID())
    }
}
