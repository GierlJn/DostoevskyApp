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
                    Image("preExile")
                        .resizable()
                        .frame(width: 35, height: 60)
                case 2:
                    Image("postExile")
                        .resizable()
                        .frame(width: 35, height: 60)
                case 3:
                  if location.books!.en.contains("Crime and Punishment"){
                    Image("rask")
                        .resizable()
                        .frame(width: 35, height: 60)
                  }else{
                    Image("hum")
                        .resizable()
                        .frame(width: 35, height: 60)
                  }
                default:
                    EmptyView()
                }
            }
    }
}


