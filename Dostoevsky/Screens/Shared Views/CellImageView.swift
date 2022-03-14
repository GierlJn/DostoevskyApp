//
//  CellImageView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 13.03.22.
//

import SwiftUI

struct CellImageView: View{
  var image: UIImage
  var rating: Int
  var isFavorite: Bool
  
  var body: some View{
    ZStack{
       Image(uiImage: image)
           .resizable()
           .frame(width: 60, height: 60)
           .clipShape(Circle())
           .padding(.vertical, 8)
     
       
       Text("\(rating)")
               .font(.system(size: 11, weight: .bold))
               .frame(width: 26, height: 18)
               .background(Color.accentLight)
               .foregroundColor(.white)
               .clipShape(Capsule())
               .offset(x: 20, y: -28)
     
     if isFavorite{
       Image(systemName: "heart.fill")
           .resizable()
           .frame(width: 15, height: 15 )
           .foregroundColor(Color(uiColor: UIColor.white))
           .offset(x: -18, y: 25)
           .shadow(radius: 8)
     }
   }
  }
}


struct CellImageView_Previews: PreviewProvider {
    static var previews: some View {
      CellImageView(image: PlaceholderImage.banner, rating: 4, isFavorite: true)
    }
}
