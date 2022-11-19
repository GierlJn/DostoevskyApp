//
//  MirroredLocationCell.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 10.03.22.
//

import SwiftUI

struct StartingLocationCell: View {
  @ObservedObject var viewModel: AppState

  var location: DLocation

  var body: some View {
    VStack {
      CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner,
                    rating: viewModel.getRatingForLocation(location: location).rating,
                    isFavorite: location.isFavorite)
        
        CellTitleVStack(alignment: .center, location: location)
          .padding(.leading)
        Text(location.localizedDescription)
            .font(.caption)
            .allowsTightening(true)
            .multilineTextAlignment(.leading)
    }
  }

}

struct StartingLocationCell_Previews: PreviewProvider {

  static var previews: some View {
    StartingLocationCell(viewModel: AppState(), location: MockData.createMockLocation())
  }
}

struct CellTitleVStack: View {
  var alignment: HorizontalAlignment
  var location: DLocation

  var body: some View {
    VStack(alignment: alignment) {
      Text(location.localizedName)
        .font(.title2)
        .fontWeight(.semibold)
        .lineLimit(2)
        .minimumScaleFactor(0.75)

      if let date = location.localizedDate {
        Text(date)
          .font(.body)
          .fontWeight(.none)
          .lineLimit(1)
          .minimumScaleFactor(0.6)
      } else if let book = location.localizedBook {
        Text(book)
          .font(.body)
          .fontWeight(.none)
          .lineLimit(1)
          .minimumScaleFactor(0.6)
      }
    }
  }
}
