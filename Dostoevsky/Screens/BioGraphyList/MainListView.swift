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
                Text(L10n.Map.Filter.Option.beforeexile)
              Spacer()
              Menu(L10n.Compactlist.Action.sort){
                  Picker(selection: $sortSettings[0], label: Text(L10n.Compactlist.Action.sort)){
                      Text(L10n.Compactlist.Sort.Option.date).tag(SortType.date)
                      Text(L10n.Compactlist.Sort.Option.rating).tag(SortType.rating)
                      Text(L10n.Compactlist.Sort.Option.favorites).tag(SortType.favorite)
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
              Text(L10n.Map.Filter.Option.afterexile)
            Spacer()
            Menu(L10n.Compactlist.Action.sort){
              Picker(selection: $sortSettings[1], label: Text(L10n.Compactlist.Action.sort)){
                  Text(L10n.Compactlist.Sort.Option.date).tag(SortType.date)
                  Text(L10n.Compactlist.Sort.Option.rating).tag(SortType.rating)
                  Text(L10n.Compactlist.Sort.Option.favorites).tag(SortType.favorite)
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
              LocationCell(viewModel: viewModel, location: location)
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
        loc1.isFavorite && !loc2.isFavorite
      }
    }
  }
  
  func filteredLocations(for category: Categories)->[DLocation]{
    viewModel.locations.filter{$0.definedCategory == category}
  }
}


