//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI



struct MainListView: View {
    
    @ObservedObject var viewModel = LocationDetailViewModel()

    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.locations, id: (\.self)){ location in
                    NavigationLink {
                        LocationDetailPushView(viewModel: viewModel, selectedLocation: location)
                    } label: {
                        LocationCell(location: location)
                    }
                }
            }
        }.accentColor(.white)
        
        
        
    }
    
    

}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}


