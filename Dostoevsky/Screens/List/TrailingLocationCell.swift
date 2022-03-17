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
          CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner, rating: viewModel.getRatingForLocation(location: location).rating, isFavorite: location.isFavorite)
          
          CellTitleVStack(alignment: .leading, location: location)
            .padding(.leading)
        }
        .padding(.horizontal)
    }

}


struct MirroredLocationCell_Previews: PreviewProvider {

    static var previews: some View {
      TrailingLocationCell(viewModel: AppState(), location: MockData.createMockLocation())
    }
}


