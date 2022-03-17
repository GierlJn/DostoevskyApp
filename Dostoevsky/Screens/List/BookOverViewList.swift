//
//  BookOverViewList.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 11.03.22.
//

import SwiftUI

struct Book: Codable, Hashable{
  let en, ru: String
  
  var localizedName: String{
    isRussian() ? ru : en
  }
  
  var image: Image{
    return Image(en)
  }
}

struct BookOverViewList: View {
  
  @State var books = Bundle.main.decode([Book].self, from: "books.json")
  @EnvironmentObject var appState: AppState
  var body: some View {
    NavigationView{
      VStack{
        if books.isEmpty{
          EmptyView().background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
          )
        }else{
          VStack{
            Spacer()
            ForEach(books, id: \.self){ book in
              VStack(alignment: .leading){
                NavigationLink {
                  BooksListView(book: book)
                } label: {
                  VStack{
                    book.image
                      .resizable()
                      .frame(height: 150)
                      .clipShape(RoundedRectangle(cornerRadius: 12))
                    
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
            Spacer()
          }
          .padding()
          .background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
          )
          
        }
        
        
      }
      
    }
    
    
  }
}

