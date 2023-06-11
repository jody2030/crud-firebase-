//
//  BookDetailsView.swift
//  DevSwiftUI
//
//  Created by Nojood Aljuaid  on 20/11/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailsView: View {
    @Environment (\.presentationMode) var presentationMode
    @State var presentEditBookSheet = false
    
    var book : Book
    
    private func editButton (action : @escaping () ->Void ) -> some View {
        Button (action: { action () }) {
            Text("Edit")
        }
    }
    var body: some View {
        Form {
              Section(header: Text("Book")) {
                Text(book.title)
                Text("\(book.numberOfPages) pages")
              }
               
              Section(header: Text("Author")) {
                Text(book.author)
              }
              Section(header: Text("Photo")) {
                  AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 300, height: 300)
              }
            }
            .navigationBarTitle(book.title)
            .navigationBarItems(trailing: editButton {
                self.presentEditBookSheet.toggle()
            })
            .onAppear() {
                print("BookDetailsView.onAppear() for \(self.book.title)")
            }
            .onDisappear() {
                print("BookDetailsView.onDisappear()")
            }
            .sheet(isPresented: self.$presentEditBookSheet){
    BookEditView(viewModel: BookViewModel(book: book), mode: .edit) { result in
        if case .success (let action) = result , action == .delete {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
            }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(title: "Coder", author: "Cairocoders", numberOfPages: 23, image: "photo1")
        return
        NavigationView {
            BookDetailsView(book: book)
        }
    }
}
