//
//  DAnnotation.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct DAnnotation: View {
    var location: DLocation
    var isFavorite: Bool
    var isRask: Bool {
        if case 3 = location.category, let books = location.books {
            if books.en.contains("Crime and Punishment") {
                return true
            }
        }
        return false
    }

    var body: some View {
            ZStack {
                switch location.category {
                case 1:
                    Image("preExile")
                        .resizable()
                        .frame(width: 35, height: 60)
                case 2:
                    Image("postExile")
                        .resizable()
                        .frame(width: 35, height: 60)
                case 3:
                  if location.books!.en.contains("Crime and Punishment") {
                    Image("rask")
                        .resizable()
                        .frame(width: 35, height: 60)
                  } else {
                    Image("hum")
                        .resizable()
                        .frame(width: 35, height: 60)
                  }
                default:
                    EmptyView()
                }
                if isFavorite {
                  Image(systemName: "heart.fill")
                      .resizable()
                      .frame(width: 15, height: 15 )
                      .foregroundColor(Color.red)
                      .offset(x: isRask ? -15 : 16, y: isRask ? -3 : -7)
                      .shadow(radius: 8)
                }
            }
    }
}


struct DAnnoation_Previews: PreviewProvider {
    static var rask: DLocation = .init(id: 0, name: .init(en: "", ru: ""), category: 3, description: .init(en: "", ru: ""), imageList: [], location: "", address: .init(en: "", ru: ""), date: nil, books: .init(en: ["Crime and Punishment"], ru: []))
    
    static var previews: some View {
        DAnnotation(location: rask, isFavorite: true)
    }
}
