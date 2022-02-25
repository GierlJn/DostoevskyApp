//
//  LocationCell.swift
//  Grab
//
//  Created by Julian Gierl on 25.08.21.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DLocation
    
    var body: some View {
        HStack{
            ZStack{
                Image(uiImage: location.previewImages.first ?? PlaceholderImage.banner)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.vertical, 8)
                
                    Text("\(location.rating)")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width: 26, height: 18)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .offset(x: 20, y: -28)
    
            }
            
            
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                if location.time != ""{
                    Text(location.time)
                        .font(.body)
                        .fontWeight(.none)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }

            }.padding(.leading)
        }
    }
}


struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DLocation(record: MockData.createLocationRecord()))
    }
}
