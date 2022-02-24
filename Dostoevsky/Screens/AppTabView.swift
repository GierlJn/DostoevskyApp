//
//  AppTabView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject var viewModel = LocationDetailViewModel()
    
    var body: some View {
        TabView{
            DMapview(viewModel: viewModel)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            MainListView(viewModel: viewModel)
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
        }.onAppear{
            if(viewModel.locations.isEmpty){
                viewModel.getLocations()
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
