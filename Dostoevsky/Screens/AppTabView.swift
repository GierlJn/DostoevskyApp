//
//  AppTabView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct AppTabView: View {
    
  @EnvironmentObject var viewModel: AppStateViewModel
    
    var body: some View {
        TabView{
            MainListView()
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
            
            DMapview()
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
