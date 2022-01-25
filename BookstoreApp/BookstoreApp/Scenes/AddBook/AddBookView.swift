//
//  AddBookView.swift
//  BookstoreApp
//
//  Created by Jelena Radojkovic on 17.1.22..
//

import SwiftUI

struct AddBookView: View {
    @ObservedObject private var viewModel = AddBookViewModel()
    @State var showImagePicker = false
    @State var selectedImage: UIImage?
    @State var imageUrl = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Author", text: $viewModel.author)
                Divider()
            }
            
            VStack {
                TextField("Name", text: $viewModel.bookName)
                Divider()
            }
            
            VStack {
                TextField("Description", text: $viewModel.description)
                Divider()
            }
            
            VStack {
                TextField("Year of publishing", text: $viewModel.yearOfPublishing)
                Divider()
            }
            
            VStack {
                TextField("Number of pages", text: $viewModel.numPages)
                Divider()
            }
            
            
            VStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    HStack {
                        Text("Upload image")
                        Image(systemName: "square.and.arrow.up")
                    }
                }.buttonStyle(WhiteishButton())
                    .border(.gray)
                    .padding(.bottom, 30)
                
                Button {
                    viewModel.addBook(imageUrl: self.imageUrl)
                    print("pressed")
                } label: {
                    Text("Add a book")
                }.buttonStyle(BlueishButton())
            }
        }.navigationBarBackButtonHidden(true)
        .padding()
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if let selectedImage = selectedImage {
                self.imageUrl = viewModel.add(image: selectedImage)
            }
            print("dismissed")
        }, content: {
            ImagePicker(image: $selectedImage)
        })
        
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
