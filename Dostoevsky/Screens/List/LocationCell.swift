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
          CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner, rating: viewModel.getRatingForLocation(location: location).rating, isFavorite: viewModel.favoriteIds.contains(where: { $0 == "\(location.localizedName)"}))
          
            VStack(alignment: .leading){
                Text(location.localizedName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                if let date = location.localizedDate{
                    Text(date)
                        .font(.body)
                        .fontWeight(.none)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }else if let book = location.localizedBook{
                  Text(book)
                    .font(.body)
                    .fontWeight(.none)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                  
                }

            }.padding(.leading)
        }
    }

}



