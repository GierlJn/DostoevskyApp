//
//  LocationDetailViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 05.03.22.
//

import SwiftUI

class LocationDetailViewModel: ObservableObject{
  
  var selectedLocation: DLocation
  @Published var userIsSwiping = false
  @Published var locationRating: Rating = Rating(record: MockData.createMockRecord())
  @Published var ratingState = 0{
    didSet{
      UserDefaults.standard.set(ratingState, forKey: selectedLocation.name.en)
    }
  }
  @Published var isFavorite = false
  @Published var disableRating = false
  @ObservedObject var appStateViewModel: AppState
  
  init(selectedLocation: DLocation, appStateViewModel: AppState){
    self.selectedLocation = selectedLocation
    self.appStateViewModel = appStateViewModel
    self.ratingState = UserDefaults.standard.integer(forKey: selectedLocation.name.en)
    self.isFavorite = selectedLocation.isFavorite
    //self.isFavorite = appStateViewModel.favoriteIds.contains("\(selectedLocation.name.en)")
    setup()
  }
  
  func setup(){
    self.locationRating = getRatingForLocation(location: selectedLocation)
  }
  
  func getRatingForLocation(location: DLocation)->Rating{
    let rating = appStateViewModel.ratings.first { rating in
      rating.place == location.id
    }
    guard rating != nil else {
      return Rating(record: MockData.createMockRecord())
    }
    return rating!
    
  }
  
  func favoriteButtonTapped(){
    //appStateViewModel.updateFavoriteIds(location: selectedLocation, newStatus: isFavorite)
    PersistanceManager.updateWith(favoriteId: selectedLocation.name.en, actionType: isFavorite ? .remove : .add) { result in
      switch result{
      case .success(_):
        self.isFavorite.toggle()
      case .failure(_):
        print("could not add fav")
      }
    }
  }
  
}
