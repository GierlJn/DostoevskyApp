//
//  BookOverViewList.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 11.03.22.
//

import SwiftUI



struct BookOverViewList: View {
  
  @State var books = BookManager.books

  var body: some View {
    NavigationView{
      Group{
        if books.isEmpty{
          EmptyView()
        }else{
          ScrollView(showsIndicators: false){
            ForEach(books, id: \.self){ book in
              VStack(alignment: .leading){
                NavigationLink {
                  BooksListView(book: book)
                } label: {
                  VStack{
                    book.image
                      .resizable()
                      .frame(height: 200)
                      .clipShape(RoundedRectangle(cornerRadius: 12))
                      .padding(.vertical, 20)
                    
                    Text(book.localizedName)
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(.white)
                      .lineLimit(1)
                      .minimumScaleFactor(0.75)
                      .padding(.horizontal)
                  }
                }
              }
            }
          }
          .padding()
        }
      }
      .background(
        LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
      )
      .navigationBarHidden(false)
      .navigationTitle("Books")
    }
  }
}

