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
                if location.category == 1{
                    Image("dostoIconGreen")
                        .resizable()
                        .frame(width: 45, height: 70)
                }else if location.category == 2{
                    Image("dostoIconGray")
                        .resizable()
                        .frame(width: 45, height: 70)
                }else if location.category == 3{
                    Image("dostoIconDarkGreen")
                        .resizable()
                        .frame(width: 45, height: 70)
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
