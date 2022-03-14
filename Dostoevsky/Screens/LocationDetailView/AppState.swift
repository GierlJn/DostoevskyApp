//
//  LocationDetailViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import MapKit
import CloudKit
import SwiftUI


enum SortType: CaseIterable{
  case date, rating, favorite
}

enum ActiveStatus: String, CaseIterable, Identifiable {
    case active
    case inactive
    
    var id: String { self.rawValue }
}

extension Collection where Element == String{
  func hasName(_ id: String)->Bool{
    self.contains(where: { $0 == "\(id)"})
  }
}

class AppState: ObservableObject{
  
  //@Published var selectedLocation: DLocation?
  @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181, longitude: 30.338418), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
  //@Published var isShowingDetailView = false
  @Published var showDetail: ActiveStatus?
  @Published var locations = [DLocation]()
  @Published var ratings = [Rating]()
  
  
  @Published var isLoadingData = false
  @Published var sort: SortType = .date{
    didSet{
      //sortLocationsBy(sort)
    }
  }
  @Published var favoriteIds = [String]()
  @Published var showingFavorites = false
  @Published var selectedLocation: DLocation?
  @Published var showCompatListVIew = false

  @AppStorage("onboard") var showsOnboard = true
  
  func getRatingForLocation(location: DLocation)->Rating{
    let rating = ratings.first { rating in
      rating.place == location.id
    }
    guard rating != nil else {
      return Rating(record: MockData.createMockRecord())
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
  
  func updateRatingForSelectedLocation(selectedLocation: DLocation, rating: Rating){
    ratings.removeAll { $0.id == rating.id}
    ratings.append(rating)
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
  
  func getDirectionsToLocation(location: DLocation) {
    let placemark = MKPlacemark(coordinate: location.getCLLocation().coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = location.name.en
    
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
  }
}
