//
//  DAnnotation.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct DAnnotation: View {
    
    var location: DLocation
    
    var body: some View {
            ZStack{
                switch location.category{
                case 1:
                    Image("dostoIconGreen")
                        .resizable()
                        .frame(width: 45, height: 70)
                case 2:
                    Image("dostoIconDarkGreen")
                        .resizable()
                        .frame(width: 45, height: 70)
                case 3:
                    Image("dostoIconGray")
                        .resizable()
                        .frame(width: 45, height: 70)
                default:
                    EmptyView()
                }

                
                
                Text("\(location.rating)")
                    .font(.system(size: 11, weight: .bold))
                    .frame(width: 26, height: 18)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .offset(x: 20, y: -28)
                
            }
            
//
//            Text("Test ")
//                .font(.caption)
//                .fontWeight(.semibold)
        
    }
}

struct DAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        DAnnotation(location: DLocation(record: MockData.createLocationRecord()))
    }
}
