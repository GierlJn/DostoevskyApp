//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI



struct BooksListView: View {
  
  @EnvironmentObject var viewModel: AppState
  @State var categories = Categories.allCases
  @State var sortSettings = SortType.date
  @State var bookName: String
  
  var body: some View {
    VStack{
      List{
        Section(header: HStack{
          HStack{
            Spacer()
            Spacer()
            Menu("Sort"){
              Picker(selection: $sortSettings, label: Text("Sort")){
                Text("Rating").tag(SortType.rating)
                Text("Favorites").tag(SortType.favorite)
              }
            }
          }
        }){
          ForEach(sortLocations(locations: viewModel.locations.novelFilteredLocations(for: bookName), sortType: sortSettings), id: (\.self)){ location in
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
      .onAppear{
        UITableView.appearance().backgroundColor = .clear
        
      }
    }
    .accentColor(.white)
    .navigationTitle(bookName)
    .navigationBarTitleDisplayMode(.inline)
    
  }
  
  func sortLocations(locations: [DLocation], sortType: SortType)->[DLocation]{
    switch sortType{
    case .date:
      return locations.sorted(by: { $0.id < $1.id })
    case .rating:
      return locations.sorted(by: { viewModel.getRatingForLocation(location: $0).rating > viewModel.getRatingForLocation(location: $1).rating })
    case .favorite:
      return locations.sorted { loc1, loc2 in
        return viewModel.favoriteIds.hasName(loc1.name.en) && !viewModel.favoriteIds.hasName(loc2.name.en)
    }
  }
}
}




