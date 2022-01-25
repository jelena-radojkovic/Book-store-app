//
//  SellerDetailsView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 13.12.21..
//

import SwiftUI

struct SellerDetailsView: View {
    @ObservedObject private var viewModel = SellerDetailsViewModel()
    @State private var selectedTab:Int = 1
    private var pageTitles = ["Add book", "Books","Profile"]
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.lightGray
    }
    
    var body: some View {
            TabView(selection: $selectedTab) {
                AddBookView()
                    .tabItem {
                        Label("New book", systemImage: "books.vertical.fill")
                    }
                    .tag(0)
                
                AdminBooks()
                    .tabItem {
                        Label("Books", systemImage: "book.fill")
                    }
                    .tag(1)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(2)
            }
            .navigationBarTitle(Text(pageTitles[selectedTab]),displayMode:.inline)
    }
}

struct SellerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SellerDetailsView()
    }
}

