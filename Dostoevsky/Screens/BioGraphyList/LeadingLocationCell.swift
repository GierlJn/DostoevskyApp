//
//  LocationCell.swift
//  Grab
//
//  Created by Julian Gierl on 25.08.21.
//

import SwiftUI


struct LeadingLocationCell: View {
    @ObservedObject var viewModel: AppState
    
    var location: DLocation

    var body: some View {
      
        HStack{
          CellTitleVStack(alignment: .trailing, location: location).padding(.trailing)
          
          CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner, rating: viewModel.getRatingForLocation(location: location).rating, isFavorite: PersistanceManager.isFavorite(location))
        }
        .padding(.vertical)
    }
}



