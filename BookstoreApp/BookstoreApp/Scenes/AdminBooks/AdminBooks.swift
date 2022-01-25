//
//  AdminBooks.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 17.1.22..
//

import SwiftUI

struct AdminBooks: View {
    @State var promotion = Persistance.shared.getBooksOnPromotion()
    @ObservedObject private var viewModel = AdminBooksViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            // filterView
            booksView
        }.navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                // in case when we add new books
                viewModel.books = Persistance.shared.getAllBooks()
            })
    }
    
    var filterView: some View {
        HStack {
            VStack {
                TextField("Book name", text: $viewModel.bookName)
                Divider()
                    .frame(width: 100, height: 1)
            }
            VStack {
                TextField("Author", text: $viewModel.author)
                Divider()
                    .frame(width: 100, height: 1)
            }
            Button {
                viewModel.filter()
                print("pressed")
            } label: {
                Text("Filter")
            }
            .buttonStyle(SmallerBlueishButton())
        }
    }
    
    var booksView: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top, 0)
            List {
                ForEach(searchText.isEmpty ? Persistance.shared.getAllBooks() : listOfBooks()) { book in
                    NavigationLink(destination: BookDetailsView(book: book,
                                                                rating: Persistance.shared.getRatingByCurrentUser(for: book.bookId) ?? 0)) {
                        HStack {
                            ImageManager.shared.getImage(imageUrl: book.imageUrl ?? "bookstore2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(book.author ?? "err")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(book.name ?? "err")
                            }
                        }
                    }
                }
            }.listStyle(PlainListStyle())
        }
    }
    
    func listOfBooks() -> [Book] {
        return viewModel.simpleFilter(name: searchText)
    }
}

@available(iOS 15.0, *)
struct AdminBooks_Previews: PreviewProvider {
    static var previews: some View {
        AdminBooks()
    }
}
