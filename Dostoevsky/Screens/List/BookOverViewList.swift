//
//  BookOverViewList.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 11.03.22.
//

import SwiftUI

struct Book: Codable, Hashable{
  let en, ru: String
  var image: Image{
    return Image(en)
  }
}

struct BookOverViewList: View {
  
  @State var books = Bundle.main.decode([Book].self, from: "books.json")
  @EnvironmentObject var appState: AppState
    var body: some View {
      VStack{
        if books.isEmpty{
          EmptyView()
        }else{
          TabView{
            ForEach(books, id: \.self){ book in
              VStack{
                Text(book.en)
                book.image
                  .resizable()
                  .frame(height: 200)
                BooksListView(bookName: book.en)
              }
            }
          }
          .tabViewStyle(PageTabViewStyle())
        }
      }
    }
}

