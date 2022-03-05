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
    
    @Published var selectedLocation: DLocation?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181, longitude: 30.338418), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Published var isShowingDetailView = false
    @Published var locations = [DLocation]()
    @Published var ratings = [LocationRating]()
    @Published var ratingState = 0{
        didSet{
            guard let selectedLocation = selectedLocation else {
                return
            }
            UserDefaults.standard.set(ratingState, forKey: selectedLocation.name.en)
        }
    }
    @Published var disableRating = false
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
    @Published var isFavorite = false
    
    @Published var favoriteIds = [String](){
        didSet{
            guard let selectedLocation = selectedLocation else {
                return
            }
            if favoriteIds.contains("\(selectedLocation.name)"){
                isFavorite = true
            }else{
                isFavorite = false
            }
        }
    }
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
    
    func updateRatingForSelectedLocation(_ newValue: Int){
        guard let selectedLocation = selectedLocation else {
            return
        }
        
        //update ratings locally
        var rating = getRatingForLocation(location: selectedLocation)
        ratings.removeAll { rating in
            rating.place == selectedLocation.id
        }
        rating.rating = newValue
        ratings.append(rating)
       
        //update ratings on server
        disableRating = true
        CloudKitManager.shared.fetchRecordN(with: selectedLocation.id) { [self] result in
            switch result{
            case .success(let record):
                record["rating"] = ratings.first(where: {$0.id == record.recordID})?.rating ?? 0
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async {
                        disableRating = false
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
    
    func setup(location: DLocation) {
        self.selectedLocation = location
        self.ratingState = UserDefaults.standard.integer(forKey: location.name.en)
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
       
    }
    
    func favoriteButtonTapped(){

        
        if !isFavorite{
            PersistanceManager.updateWith(favoriteId: "\(selectedLocation!.name)", actionType: .add) { result in
                switch result{
                case .success(let updatedIds):
                    self.favoriteIds = updatedIds
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            PersistanceManager.updateWith(favoriteId: "\(selectedLocation!.name)", actionType: .remove) { result in
                switch result{
                case .success(let updatedIds):
                    self.favoriteIds = updatedIds
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }

    
    func sortLocationsBy(_ sortType: SortType){
        locations = locations.sorted(by: { (lhs, rhs) -> Bool in
            sortType == .rating ? (getRatingForLocation(location: lhs).rating > getRatingForLocation(location: rhs).rating) : (getRatingForLocation(location: lhs).rating > getRatingForLocation(location: rhs).rating)
        })
    }
    
    func getLocations(){
        isLoadingData = true
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
    
    func getDirectionsToLocation() {
        guard let selectedLocation = selectedLocation else {
            return
        }
        
        let placemark = MKPlacemark(coordinate: selectedLocation.getCLLocation().coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = selectedLocation.name.en
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
}
