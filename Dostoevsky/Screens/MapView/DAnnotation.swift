//
//  DAnnotation.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct DAnnotation: View {
    @ObservedObject var viewModel: AppState
    var location: DLocation
    
    var body: some View {
            ZStack{
                switch location.category{
                case 1:
                    Image("preExileDosto")
                        .resizable()
                        .frame(width: 35, height: 60)
                case 2:
                    Image("dostoIconDarkGreen")
                        .resizable()
                        .frame(width: 35, height: 60)
                case 3:
                    Image("inkwell")
                        .resizable()
                        .frame(width: 35, height: 60)
                default:
                    EmptyView()
                }

                
                
                Text("\(viewModel.getRatingForLocation(location: location).rating)")
                    .font(.system(size: 11, weight: .bold))
                    .frame(width: 26, height: 18)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .offset(x: 20, y: -28)
                
            }

        
    }
}


