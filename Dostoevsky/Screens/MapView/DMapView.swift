//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

class DMapViewModel: ObservableObject{
  @Published var isShowingDetailView = false
  @Published var selectedLocation: DLocation?
}

struct DMapview: View{
  
  @EnvironmentObject var viewModel: AppStateViewModel
  @StateObject var mapViewModel = DMapViewModel()

  
  var body: some View{
    ZStack{
      VStack{
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations.filter({ loc in
          switch viewModel.filter{
          case .all:
            return true
          case .beforeExile:
            return loc.category == 1
          case .afterExile:
            return loc.category == 2
          case .novels:
            return loc.category == 3
          }
        })) { location in
          MapAnnotation(coordinate: location.getCLLocation().coordinate) {
            DAnnotation(viewModel: viewModel, location: location)
              .onTapGesture {
                mapViewModel.selectedLocation = location
                mapViewModel.isShowingDetailView = true
              }
          }
        }
      }
      
      VStack{
        Image("map-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 150)
          .shadow(color: .black, radius: 12)
          .padding()
        Spacer()
      }
      
    }
    
    
    .overlay( Picker("Filter", selection: $viewModel.filter) {
      Text("Show all").tag(FilterOptions.all)
      Text("Before exile").tag(FilterOptions.beforeExile)
      Text("After exile").tag(FilterOptions.afterExile)
      Text("Novels").tag(FilterOptions.novels)}
                .frame(width: 100, height: 35).background(RoundedRectangle(cornerRadius: 12)
                                                            .foregroundColor(getFilterColor()))
                .padding(6), alignment: .bottomTrailing)
    
    
    .edgesIgnoringSafeArea([.top, .leading, .trailing])
    .accentColor(.white)
    
    .fullScreenCover(isPresented: $mapViewModel.isShowingDetailView){
      LocationDetailView(locationDetailViewModel: LocationDetailViewModel(selectedLocation: mapViewModel.selectedLocation!, appStateViewModel: viewModel))
    }
    
    
  }
  
  func getFilterColor()->Color{
    switch viewModel.filter{
    case .all:
      return Color.brandPrimary
    case .beforeExile:
      return Color.brandCategory1
    case .afterExile:
      return Color.brandCategory2
    case .novels:
      return Color.brandCategory3
    }
  }
}
