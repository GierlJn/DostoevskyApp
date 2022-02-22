//
//  DAnnotation.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct DAnnotation: View {
    var body: some View {
        VStack{
            ZStack{
//                MapBalloon()
//                    .frame(width: 100, height: 70)
//                    .foregroundColor(.purple)
                Image("dostoAnno")
                    .resizable()
                    .frame(width: 45, height: 70)
                
            }
            
            
            Text("Test ")
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

struct DAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        DAnnotation()
    }
}
