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
      Group{
        if viewModel.showCompatListVIew{
          MainListView()
        }else{
          TimeLineView()
        }
      }
      .background(Image("lifeBackground")
                    .resizable()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing]))
      .overlay(alignment: .bottomTrailing) {
        Button {
          viewModel.showCompatListVIew.toggle()
        } label: {
          Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 17, height: 17 )
            .padding()
            .background {
              RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.tabColor)
            }
            .padding()
            
        }
        
      }
      
      
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
      UITabBar.appearance().backgroundColor = UIColor.tabColor
    }
    
    
    //.preferredColorScheme(.light)
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
