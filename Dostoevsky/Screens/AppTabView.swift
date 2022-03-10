//
//  AppTabView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct AppTabView: View {
  
  @EnvironmentObject var viewModel: AppState
  
  var body: some View {
    TabView{
      TimeLineView()
        .background(Image("lifeBackground")
                      .resizable()
                      .edgesIgnoringSafeArea([.top, .leading, .trailing]))
        .tabItem {
          Label("Biography", systemImage: "building")
        }
      
      DMapview()
        .tabItem {
          Label("Map", systemImage: "map")
        }
    }.onAppear{
      if(viewModel.locations.isEmpty){
        viewModel.setup()
      }
      UITabBar.appearance().backgroundColor = UIColor(named: "tabColor")
    }
    
    
    .preferredColorScheme(.light)
    
    .accentColor(.black)
    .overlay(viewModel.isLoadingData ? LoadingView() : nil)
    .fullScreenCover(item: $viewModel.showDetail, content: {_ in
      LocationDetailView(locationDetailViewModel: LocationDetailViewModel(selectedLocation: viewModel.selectedLocation!, appStateViewModel: viewModel))
    })
    
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView()
  }
}
