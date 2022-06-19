//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View {

  @EnvironmentObject var viewModel: AppState
  @StateObject var mapViewModel = DMapViewModel()
  @State var numberOfPeople = 0

  var body: some View {
    ZStack {
      VStack {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations.filter({ loc in
          switch mapViewModel.filter {
          case .favorites:
            return loc.isFavorite
          case .beforeExile:
            return loc.category == 1
          case .afterExile:
            return loc.category == 2
          case .crime:
            return loc.bookType == .crimeAndPunishment
          case .humililated:
            return loc.bookType == .humiliatedAndInsulted
          }
        })) { location in
          MapAnnotation(coordinate: location.getCLLocation().coordinate) {
            DAnnotation(location: location)
              .onTapGesture {
                viewModel.selectedLocation = location
                viewModel.showDetail = ActiveStatus.active
              }
          }
        }
      }
    }
    .onAppear {
      if !CommandLine.arguments.contains("--UITests") {
        mapViewModel.checkIfLocationServicesIsEnabled()
      }
    }
    .overlay(PickerView(viewModel: mapViewModel), alignment: .bottomTrailing)
    .edgesIgnoringSafeArea([.top, .leading, .trailing])
    .accentColor(.white)
  }
}

struct PickerView: View {
  @StateObject var viewModel: DMapViewModel
  var body: some View {
    Picker("Filter", selection: $viewModel.filter) {
        Text(L10n.Map.Filter.Option.favorites).tag(FilterOptions.favorites)
        Text(L10n.Map.Filter.Option.beforeexile).tag(FilterOptions.beforeExile)
        Text(L10n.Map.Filter.Option.afterexile).tag(FilterOptions.afterExile)
        Text(L10n.Book.Title.crimeandpunishment).tag(FilterOptions.crime)
        Text(L10n.Book.Title.humiliatedandinsulted).tag(FilterOptions.humililated)}
    .padding(.horizontal)
    .background(RoundedRectangle(cornerRadius: 12)
      .foregroundColor(.accentLight))
    .padding(6)
  }
}
