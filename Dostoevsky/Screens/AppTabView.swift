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
            MainListView(viewModel: viewModel)
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
            
            DMapview(viewModel: viewModel)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }.onAppear{
            if(viewModel.locations.isEmpty){
                viewModel.getLocations()
            }
        }
        .accentColor(.brandCategory3)
        .overlay(viewModel.isLoadingData ? LoadingView() : nil)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
