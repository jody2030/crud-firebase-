//
//  BooksViewModel.swift
//  DevSwiftUI
//
//  Created by Nojood Aljuaid  on 20/11/1444 AH.
//

import Foundation
import Combine
import FirebaseFirestore
 
class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
      
     deinit {
       unsubscribe()
     }
      
     func unsubscribe() {
       if listenerRegistration != nil {
         listenerRegistration?.remove()
         listenerRegistration = nil
       }
     }
      
     func subscribe() {
       if listenerRegistration == nil {
         listenerRegistration = db.collection("books").addSnapshotListener { (querySnapshot, error) in
           guard let documents = querySnapshot?.documents else {
             print("No documents")
             return
           }
            
           self.books = documents.compactMap { queryDocumentSnapshot in
             try? queryDocumentSnapshot.data(as: Book.self)
           }
         }
       }
     }
      
     func removeBooks(atOffsets indexSet: IndexSet) {
       let books = indexSet.lazy.map { self.books[$0] }
       books.forEach { book in
         if let documentId = book.id {
           db.collection("books").document(documentId).delete { error in
             if let error = error {
               print("Unable to remove document: \(error.localizedDescription)")
             }
           }
         }
       }
     }
    
}
