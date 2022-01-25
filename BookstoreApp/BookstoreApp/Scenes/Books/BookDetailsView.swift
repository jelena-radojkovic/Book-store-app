//
//  BookDetailsView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 16.12.21..
//


import SwiftUI

struct BookDetailsView: View {
    @State var book: Book
    @State var rating: Int
    @ObservedObject private var viewModel = BookDetailsViewModel()
    @State var leaveComment = false
    let maximumRating = 5
    var offImage: Image?
    let onImage = Image(systemName: "star.fill")
    let offColor = Color.gray
    let onColor = Color.yellow
    
    var body: some View {
        ScrollView {
            VStack {
                Text(book.name ?? "X")
                    .font(.headline)
                Text(book.author ?? "X")
                    .font(.subheadline)
                ImageManager.shared.getImage(imageUrl: book.imageUrl ?? "X")
                    .resizable()
                    .frame(width: 200 , height: 250)
                    .padding()
                Text(book.bookDescription ?? "X")
                    .font(.title)
                    .bold()
                    .padding()
                Text("Godina izdanja: \(book.publishedYear)")
                Text("Broj stranica: \(book.numPages)")
                
                if let userType = Persistance.currentUser?.userType,
                   userType == UserType.customer.rawValue {
                    HStack {
                        ForEach(1..<maximumRating + 1, id: \.self) { number in
                            image(for: number)
                                .foregroundColor(number > rating ? offColor : onColor)
                                .onTapGesture {
                                    rating = number
                                    if let id = book.bookId {
                                        viewModel.rateBook(bookId: id, rating: rating)
                                    }
                                }
                        }
                    }
                } else {
                    if let book = book {
                        Toggle("On promotion", isOn: $book.promotion)
                            .padding(.horizontal, 60)
                            .padding()
                            .onTapGesture {
                                viewModel.changePromotionStatus(for: book)
                            }
                    }
                }
                
                NavigationLink {
                    CommentsView(bookId: (book.bookId)!)
                } label: {
                    Text("Read comments")
                }.buttonStyle(BlueishButton())
                    .padding(.top, 10)
                
                if let userType = Persistance.currentUser?.userType,
                   userType == UserType.customer.rawValue {
                    Button("Leave a comment") {
                        leaveComment = true
                    }.buttonStyle(BlueishButton())
                    
                    NavigationLink {
                        RecommendABookView(bookId: book.bookId)
                    } label: {
                        Text("Recommend this book")
                    }.buttonStyle(PurpleishButton())
                        .padding()
                }
            }.navigationTitle("Book details")
        }.onAppear {
            // in case when we rate a book, we need to refresh books' info
            rating = Persistance.shared.getRatingByCurrentUser(for: book.bookId) ?? 0
        }
        .sheet(isPresented: $leaveComment) {
            print("dismissed")
        } content: {
            postComment
        }
    }
    
    var postComment: some View {
        VStack {
            Group {
                TextField("Type in comment", text: $viewModel.comment)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.gray.opacity(0.7))
            .multilineTextAlignment(.center)
            .padding(.trailing, 15)
            .padding(.leading, 15)
            .frame(width: 300, height: 200)
            
            Spacer()
            
            Button("Submit") {
                if let id = book.bookId {
                    viewModel.leaveComment(bookId: id)
                }
                leaveComment = false
            }.buttonStyle(BlueishButton())
                .padding()
        }
    }
    
    private func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}
