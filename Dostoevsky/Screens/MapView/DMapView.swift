//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View{
  
  @EnvironmentObject var viewModel: AppState
  @StateObject var mapViewModel = DMapViewModel()
  @State var numberOfPeople = 0
  
  var body: some View{
    ZStack{
      VStack{
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations.filter({ loc in
          switch mapViewModel.filter{
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
                viewModel.selectedLocation = location
                viewModel.isShowingDetailView = true
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
        
        
        Picker("Number of people", selection: $numberOfPeople) {
                ForEach(2 ..< 100) {
                    Text("\($0) people")
                }
        }
        
      }
    }
    .edgesIgnoringSafeArea([.top, .leading, .trailing])
    .accentColor(.white)
  }
  
  
}

struct PickerView: View{
  @StateObject var viewModel: DMapViewModel
  var body: some View{
    Picker("Filter", selection: $viewModel.filter) {
      Text("Show all").tag(FilterOptions.all)
      Text("Before exile").tag(FilterOptions.beforeExile)
      Text("After exile").tag(FilterOptions.afterExile)
      Text("Novels").tag(FilterOptions.novels)}
//
//      .frame(width: 100, height: 35).background(RoundedRectangle(cornerRadius: 12)
//                                                  .foregroundColor(viewModel.filter.getFilterColor))
//      .padding(6)
  }
}
