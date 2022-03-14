//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI



struct MainListView: View {
  
  @EnvironmentObject var viewModel: AppState
  @State var categories = Categories.allCases
  @State var sortSettings = [SortType.date, SortType.date]
  
  var body: some View {
    VStack{
      List{
        if !sortedLocations(section: 0, sortType: sortSettings[0]).isEmpty{
          Section(header: HStack{
            HStack{
              Text("Before Exile")
              Spacer()
              Menu("Sort"){
                Picker(selection: $sortSettings[0], label: Text("Sort")){
                  Text("Date").tag(SortType.date)
                  Text("Rating").tag(SortType.rating)
                  Text("Favorites").tag(SortType.favorite)
                }
              }
            }
          }){
            ForEach(sortedLocations(section: 0, sortType: sortSettings[0]), id: (\.self)){ location in
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
        
        if !sortedLocations(section: 1, sortType: sortSettings[1]).isEmpty{
        Section(header: HStack{
          HStack{
            Text("After Exile")
            Spacer()
            Menu("Sort"){
              Picker(selection: $sortSettings[1], label: Text("Sort")){
                Text("Date").tag(SortType.date)
                Text("Rating").tag(SortType.rating)
                Text("Favorites").tag(SortType.favorite)
              }
            }
          }
        }){
          ForEach(sortedLocations(section: 1, sortType: sortSettings[1]), id: (\.self)){ location in
            Button {
              DispatchQueue.main.async {
                viewModel.selectedLocation = location
                viewModel.showDetail = ActiveStatus.active
              }
            } label: {
              LocationCell(viewModel: viewModel, location: location)//.listRowBackground(Color.tabColor)
            }
            }
          }
        }
        
      }
    }
    
    .background(
      LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
    )
    .accentColor(.white)
    .navigationBarHidden(true)
    
  }
  
  func sortedLocations(section: Int, sortType: SortType)->[DLocation]{
    sortLocations(locations: filteredLocations(for: Categories.allCases[section]), sortType: sortType)
  }
  
  func sortLocations(locations: [DLocation], sortType: SortType)->[DLocation]{
    switch sortType{
    case .date:
      return locations.sorted(by: { $0.id < $1.id })
    case .rating:
      return locations.sorted(by: { viewModel.getRatingForLocation(location: $0).rating > viewModel.getRatingForLocation(location: $1).rating })
    case .favorite:
      return locations.sorted { loc1, loc2 in
        viewModel.favoriteIds.hasName(loc1.name.en) && !viewModel.favoriteIds.hasName(loc2.name.en)
      }
    }
  }
  
  func filteredLocations(for category: Categories)->[DLocation]{
    viewModel.locations.filter{$0.definedCategory == category}
//    .filter({ loc in
//      viewModel.favoriteIds.contains("\(loc.name)")
//    })
  }
}


