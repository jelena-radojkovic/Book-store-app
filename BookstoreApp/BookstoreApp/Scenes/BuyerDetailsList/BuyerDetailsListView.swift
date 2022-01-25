//
//  BuyerDetailsListView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import SwiftUI

struct BuyerDetailsListView: View {
    @State private var books = Persistance.shared.getAllBooks()
    @State private var booksOnPromotion = Persistance.shared.getBooksOnPromotion()
    @State private var selectedTab:Int = 1
    @State private var showPromotionBooks = false
    private var pageTitles = ["Recommended books", "Books","Profile"]
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.lightGray
    }
    
    var body: some View {
            TabView(selection: $selectedTab) {
                RecommendedBooksView()
                    .tabItem {
                        Label("Recommended", systemImage: "books.vertical.fill")
                    }
                    .tag(0)
                
                booksView
                    .tabItem {
                        Label("Books", systemImage: "book.fill")
                    }
                    .tag(1)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(2)
        }.navigationBarTitle(Text(pageTitles[selectedTab]),displayMode:.inline)
            .onAppear {
            // in case when we add a new book, we need to fetch new data
            books = Persistance.shared.getAllBooks()
            booksOnPromotion = Persistance.shared.getBooksOnPromotion()
        }
    }
    
    var booksView : some View {
        VStack {
        List {
            ForEach(books) { book in
                NavigationLink(destination: BookDetailsView(book: book,
                                                            rating: Persistance.shared.getRatingByCurrentUser(for: book.bookId) ?? 0)) {
                    HStack {
                         ImageManager.shared.getImage(imageUrl: book.imageUrl ?? "X")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(book.author ?? "err")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(book.name ?? "err")
                            if book.promotion {
                                Text("on promotion")
                                    .foregroundColor(.red)
                                    .font(Font.footnote)
                            }
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .listStyle(PlainListStyle())
        
            NavigationLink(isActive: $showPromotionBooks) {
                booksOnPromotionView
            } label: {
                Text("On promotion")
            }.buttonStyle(BlueishButton())
        }
    }
    
    var booksOnPromotionView: some View {
        List {
            ForEach(booksOnPromotion) { book in
                NavigationLink(destination: BookDetailsView(book: book,
                                                            rating: Persistance.shared.getRatingByCurrentUser(for: book.bookId) ?? 0)) {
                    HStack {
                        ImageManager.shared.getImage(imageUrl: book.imageUrl ?? "X")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(book.author ?? "err")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(book.name ?? "err")
                            if book.promotion {
                                Text("on promotion")
                                    .foregroundColor(.red)
                                    .font(Font.footnote)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Books on promotion")
        .listStyle(PlainListStyle())
    }
}

struct BuyerDetailsListView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerDetailsListView()
    }
}

