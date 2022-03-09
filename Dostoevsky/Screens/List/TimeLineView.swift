//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

struct TimeLineView: View {
  
  @EnvironmentObject var viewModel: AppState
  @State var categories = Categories.allCases
  @State var sortSettings = Array.init(repeating: SortType.date, count: Categories.allCases.count)
  
  
  
  var body: some View {
    
        VStack{
          ScrollView{
            ForEach(Array(sortLocations(locations: filteredLocations(for: Categories.allCases[0]), sortType: sortSettings[0]).enumerated()), id: (\.element)){ index, location in
              
              Button {
                DispatchQueue.main.async {
                  viewModel.selectedLocation = location
                  viewModel.showDetail = ActiveStatus.active
                }
              } label: {
                ZStack{
                  GeometryReader{ reader in
                    TimeLineLocationCell(viewModel: viewModel, location: location, mirrored: index % 2 == 0)
                      
                    
                    
                  }
                }
                .padding()
                .padding(.vertical)
                
                
              }
          
        }
      }
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


