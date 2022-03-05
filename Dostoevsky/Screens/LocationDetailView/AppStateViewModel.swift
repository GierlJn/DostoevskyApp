//
//  LocationDetailViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import MapKit
import CloudKit

enum SortType{
  case date, rating
}

enum FilterOptions{
  case all, beforeExile, afterExile, novels
}

class AppStateViewModel: ObservableObject{
  
  //@Published var selectedLocation: DLocation?
  @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181, longitude: 30.338418), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
  @Published var isShowingDetailView = false
  @Published var locations = [DLocation]()
  @Published var ratings = [LocationRating]()
  
  
  @Published var isLoadingData = false
  @Published var sort: SortType = .date{
    didSet{
      sortLocationsBy(sort)
    }
  }
  @Published var filter: FilterOptions = .all{
    didSet{
      
    }
  }
  
  @Published var favoriteIds = [String]()
  @Published var showingFavorites = false
  
  func getRatingForLocation(location: DLocation)->LocationRating{
    let rating = ratings.first { rating in
      rating.place == location.id
    }
    guard rating != nil else {
      return LocationRating(record: MockData.createMockRecord())
    }
    return rating!
    
  }
  
  func updateFavoriteIds(location: DLocation, newStatus: Bool){
    if !newStatus{
      PersistanceManager.updateWith(favoriteId: "\(location.name)", actionType: .add) { result in
        switch result{
        case .success(let updatedIds):
          self.favoriteIds = updatedIds
        case .failure(let error):
          print(error)
        }
      }
    }else{
      PersistanceManager.updateWith(favoriteId: "\(location.name)", actionType: .remove) { result in
        switch result{
        case .success(let updatedIds):
          self.favoriteIds = updatedIds
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  func updateRatingForSelectedLocation(selectedLocation: DLocation, rating: LocationRating){
    ratings.removeAll { $0.id == rating.id}
    ratings.append(rating)

    //disableRating = true
    CloudKitManager.shared.fetchRecordN(with: selectedLocation.id) { [self] result in
      switch result{
      case .success(let record):
        record["rating"] = rating.rating
        CloudKitManager.shared.save(record: record) { result in
          DispatchQueue.main.async {
            //disableRating = false
            switch result{
            case .success(let record):
              print("saved successfully ")
            case .failure(let error):
              print(error)
            }
          }
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func setup() {
    isLoadingData = true
    PersistanceManager.retrieveFavoriteIds(completed: { result in
      switch result{
      case .success(let ids):
        self.favoriteIds = ids
        print(self.favoriteIds)
      case .failure(let error):
        print(error)
#warning("error")
      }
    })
    
    self.locations = Bundle.main.decode([DLocation].self, from: "locations.json")
    CloudKitManager.shared.getLocationRatings { [self] result in
      DispatchQueue.main.async {
        isLoadingData = false
        switch(result){
        case .success(let ratings):
          self.ratings = ratings
        case .failure(_):
          print("error")
        }
      }
    }
    
  }
  
  func sortLocationsBy(_ sortType: SortType){
    locations = locations.sorted(by: { (lhs, rhs) -> Bool in
      sortType == .rating ? (getRatingForLocation(location: lhs).rating > getRatingForLocation(location: rhs).rating) : (getRatingForLocation(location: lhs).rating > getRatingForLocation(location: rhs).rating)
    })
  }
  
  
  func getDirectionsToLocation(location: DLocation) {
    let placemark = MKPlacemark(coordinate: location.getCLLocation().coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = location.name.en
    
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
  }
}
