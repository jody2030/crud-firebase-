//
//  ContentView.swift
//  DevSwiftUI
//
//  Created by Nojood Aljuaid  on 20/11/1444 AH.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var viewModel = BooksViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddBookSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    private func bookRowView(book: Book) -> some View {
         NavigationLink(destination: BookDetailsView(book: book)) {
           VStack(alignment: .leading) {
               HStack {
                   AnimatedImage(url: URL(string: book.image))
                    .resizable()
                       .frame(width: 65, height: 65).clipShape(Circle())
                    
                   VStack(alignment: .leading) {
                       Text(book.title)
                           .fontWeight(.bold)
                       Text(book.author)
                   }
               }
           }
         }
       }
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.books) { book in
                    bookRowView(book: book)
                        
                }
                .onDelete() { indexSet in
                    viewModel.removeBooks(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Books")
            .navigationBarItems(trailing: addButton)
            .onAppear(){
                print("BooksListView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddBookSheet) {
                BookEditView()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
