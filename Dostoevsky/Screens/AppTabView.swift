//
//  AppTabView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct AppTabView: View {
  
  @EnvironmentObject var viewModel: AppState
  @State var buttonPressed = false
  var body: some View {
    TabView{
      Group{
        if viewModel.showCompatListVIew{
          MainListView()
        }else{
          TimeLineView()
        }
      }
      .background(
        LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
      )
      .overlay(alignment: .bottomTrailing) {
        
        Button {
          withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)){
            viewModel.showCompatListVIew.toggle()
          }
        } label: {

          AnimatedListButton(isPressed: $viewModel.showCompatListVIew)

        }
        .padding()
      }
      .tabItem {
        Label("Biography", systemImage: "building")
      }
      
      BookOverViewList()
        .tabItem {
          Label("Books", systemImage: "book")
        }
      
      DMapview()
        .background(
          LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .tabItem {
          Label("Map", systemImage: "map")
        }
      AboutView()
        .tabItem {
          Label("About", systemImage: "info")
        }
      
      
    }.onAppear{
      if(viewModel.locations.isEmpty){
        viewModel.setup()
      }
    }
    .accentColor(.customAccentColor)
    .overlay(viewModel.isLoadingData ? LoadingView() : nil)
    .sheet(item: $viewModel.showDetail, content: { _ in
      LocationDetailView(locationDetailViewModel: LocationDetailViewModel(selectedLocation: viewModel.selectedLocation!, appStateViewModel: viewModel))
    })
    
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView()
  }
}

