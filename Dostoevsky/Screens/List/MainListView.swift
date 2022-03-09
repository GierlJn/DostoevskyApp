//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

enum Categories: CaseIterable, Equatable{
  case beforeExile
  case afterExile
  case novels
}

struct MainListView: View {
  
  @EnvironmentObject var viewModel: AppState
  @State var categories = Categories.allCases
  @State var sortSettings = Array.init(repeating: SortType.date, count: Categories.allCases.count)
  
  var body: some View {
    VStack{
      HStack{
        Button {
          viewModel.showingFavorites.toggle()
        } label: {
          Label("Favorites", systemImage: "heart.fill")
        }
        
        Spacer()
        Spacer()
      }
      
      .padding(.top)
      .padding(.horizontal)
      List{
        Section(header: HStack{
          HStack{
            Text("Before Exile")
            Spacer()
            Menu("Sort"){
              Picker(selection: $sortSettings[0], label: Text("Sort")){
                Text("Date").tag(SortType.date)
                Text("Rating").tag(SortType.rating)
              }
            }
          }
        }){
          ForEach(sortLocations(locations: filteredLocations(for: Categories.allCases[0]), sortType: sortSettings[0]), id: (\.self)){ location in
            Button {
              DispatchQueue.main.async {
                viewModel.selectedLocation = location
                viewModel.showDetail = ActiveStatus.active
              }
            } label: {
              LocationCell(viewModel: viewModel, location: location)
            }
            
          }
        }
        Section(header: HStack{
          HStack{
            Text("After Exile")
            Spacer()
            Menu("Sort"){
              Picker(selection: $sortSettings[1], label: Text("Sort")){
                Text("Date").tag(SortType.date)
                Text("Rating").tag(SortType.rating)
              }
            }
          }
        }){
          ForEach(sortLocations(locations: filteredLocations(for: Categories.allCases[1]), sortType: sortSettings[0]), id: (\.self)){ location in
            Button {
              DispatchQueue.main.async {
                viewModel.selectedLocation = location
                viewModel.showDetail = ActiveStatus.active
              }
            } label: {
              LocationCell(viewModel: viewModel, location: location)
            }
            
          }
        }
        Section(header: HStack{
          HStack{
            Text("Novels")
            Spacer()
            Menu("Sort"){
              Picker(selection: $sortSettings[2], label: Text("Sort")){
                Text("Rating").tag(SortType.rating)
              }
            }
          }
        }){
          ForEach(sortLocations(locations: filteredLocations(for: Categories.allCases[2]), sortType: sortSettings[0]), id: (\.self)){ location in
            Button {
              DispatchQueue.main.async {
                viewModel.selectedLocation = location
                viewModel.showDetail = ActiveStatus.active
              }
            } label: {
              LocationCell(viewModel: viewModel, location: location)
            }
            
          }
        }
      }
      Spacer()
      
    }
    .foregroundColor(.primary)
    .accentColor(.primary)
    .navigationBarHidden(true)
    
  }
  
  func sortLocations(locations: [DLocation], sortType: SortType)->[DLocation]{
    switch sortType{
    case .date:
      return locations.sorted(by: { $0.id < $1.id })
    case .rating:
      return locations.sorted(by: { viewModel.getRatingForLocation(location: $0).rating > viewModel.getRatingForLocation(location: $1).rating })
    }
  }
  
  func filteredLocations(for category: Categories)->[DLocation]{
    viewModel.showingFavorites ? viewModel.locations.filter{$0.definedCategory == category}.filter({ loc in
      viewModel.favoriteIds.contains("\(loc.name)")
    }) : viewModel.locations.filter{$0.definedCategory == category}
  }
}


