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
        ZStack{
            Image(uiImage: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.vertical, 8)
          
            
            Text("\(viewModel.getRatingForLocation(location: location).rating)")
                    .font(.system(size: 11, weight: .bold))
                    .frame(width: 26, height: 18)
                    //.background(Color.red)
                    //.foregroundColor(.white)
                    .clipShape(Capsule())
                    .offset(x: 20, y: -28)
          
          if viewModel.favoriteIds.contains(where: { $0 == "\(location.name)"}){
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 15, height: 15 )
                //.foregroundColor(.red)
                .offset(x: -18, y: 25)
                .shadow(radius: 8)
          }
        }
        HStack{
          VStack(alignment: .center){
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
      }
    }

}


struct StartingLocationCell_Previews: PreviewProvider {

    static var previews: some View {
      StartingLocationCell(viewModel: AppState(), location: MockData.createMockLocation())
    }
}
