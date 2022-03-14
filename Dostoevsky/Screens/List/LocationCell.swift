//
//  LocationCell.swift
//  Grab
//
//  Created by Julian Gierl on 25.08.21.
//

import SwiftUI

struct LocationCell: View {
    @ObservedObject var viewModel: AppState
    
    var location: DLocation
    var body: some View {

        HStack{
          CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner, rating: viewModel.getRatingForLocation(location: location).rating, isFavorite: viewModel.favoriteIds.contains(where: { $0 == "\(location.name)"}))
          
            VStack(alignment: .leading){
                Text(location.name.en)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                if let date = location.date{
                    Text(date.en)
                        .font(.body)
                        .fontWeight(.none)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }else if let allBooks = allBooksEn{
                  Text(allBooks)
                    .font(.body)
                    .fontWeight(.none)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                  
                }

            }.padding(.leading)
        }
    }
  
  var allBooksEn: String?{
    guard let books = location.books?.en else{
      return nil
    }
    var res = ""
    for book in books{
      if res.isEmpty{
        res = "\(book)"
      }else{
        res += "and \(book)"
      }
    }
    return res
  }
}



