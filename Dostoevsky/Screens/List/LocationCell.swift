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
            ZStack{
                Image(uiImage: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.vertical, 8)
                
                Text("\(viewModel.getRatingForLocation(location: location).rating)")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width: 26, height: 18)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .offset(x: 20, y: -28)
    
            }
            
            
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
                }

            }.padding(.leading)
        }
    }
}



