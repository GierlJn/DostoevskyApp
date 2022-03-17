//
//  LocationCell.swift
//  Grab
//
//  Created by Julian Gierl on 25.08.21.
//

import SwiftUI


struct EndingLocationCell: View {
  
  @ObservedObject var viewModel: AppState
  var location: DLocation
  
  var body: some View {
    
    HStack{
      VStack(alignment: .trailing){
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
        }else if let book = location.localizedBook{
          Text(book)
            .font(.body)
            .fontWeight(.none)
            .lineLimit(1)
            .minimumScaleFactor(0.6)
          
        }
        
      }.padding(.trailing)
      
      CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner, rating: viewModel.getRatingForLocation(location: location).rating, isFavorite: viewModel.favoriteIds.contains(where: { $0 == "\(location.name.en)"}))
    }
    .padding(.vertical)
  }
}

struct EndingLocationCell_Previews: PreviewProvider {
  
  static var previews: some View {
    EndingLocationCell(viewModel: AppState(), location: MockData.createMockLocation())
  }
}


