//
//  MirroredLocationCell.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 10.03.22.
//

import SwiftUI

struct TrailingLocationCell: View {
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
                }else if let allBooks = location.allBooksEn{
                  Text(allBooks)
                    .font(.body)
                    .fontWeight(.none)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                  
                }

            }.padding(.leading)
        }
        .padding(.horizontal)
    }

}


struct MirroredLocationCell_Previews: PreviewProvider {

    static var previews: some View {
      TrailingLocationCell(viewModel: AppState(), location: MockData.createMockLocation())
    }
}


