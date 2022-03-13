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
  @State var sortSettings = Array.init(repeating: SortType.date, count: Categories.allCases.count)
  @State var bookName: String
  
  var body: some View {
    VStack{
      List{
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
          ForEach(sortLocations(locations: viewModel.locations.novelFilteredLocations(for: bookName), sortType: sortSettings[2]), id: (\.self)){ location in
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
  
 // func filteredLocations(for category: Categories)->[DLocation]{
//    viewModel.showingFavorites ? viewModel.locations.filter{$0.definedCategory == category}.filter({ loc in
//      viewModel.favoriteIds.contains("\(loc.name)")
//    }) : viewModel.locations.filter{$0.definedCategory == category}
//    viewModel.locations.novelLocations.filter{$0.books?.en.contains(where: { str in
//      str == book.en
//    }) }
//      .filter({ loc in
//      viewModel.favoriteIds.contains("\(loc.name)")
//    })
  //}
}


