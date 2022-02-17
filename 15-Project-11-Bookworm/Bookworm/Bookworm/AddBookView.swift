//
//  AddBookView.swift
//  Bookworm
//
//  Created by Matt X on 2/15/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @State private var isShowingAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery",
                  "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save", action: saveBook)
                }
            }
            .navigationTitle("Add Book")
            .alert("Missing Info", isPresented: $isShowingAlert) {
                Button("OK") { }
            } message: {
                Text("Please make sure to provide the book's name, author, and genre.")
            }
        }
    }
    
    func hasMinimumBookInfoProvided() -> Bool {
        !title.isEmpty && !author.isEmpty && !genre.isEmpty
    }
    
    func saveBook() {
        guard hasMinimumBookInfoProvided() else {
            isShowingAlert = true
            return
        }
        
        let newBook = Book(context: managedObjectContext)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.review = review
        newBook.date = Date.now
        
        try? managedObjectContext.save()
        
        dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
