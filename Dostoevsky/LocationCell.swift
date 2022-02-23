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
            Image(uiImage: location.createBannerImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

            }.padding(.leading)
        }
    }
}


struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DLocation(record: MockData.createLocationRecord()))
    }
}
