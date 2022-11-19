import SwiftUI

class LocationDetailViewModel: ObservableObject {
    
    var selectedLocation: DLocation
    @Published var userIsSwiping = false
    @Published var locationRating: Rating = Rating(record: MockData.createMockRecord())
    @Published var ratingState = 0 {
        didSet {
            UserDefaults.standard.set(ratingState, forKey: selectedLocation.name.en)
        }
    }
    @Published var isFavorite = false
    @Published var disableRating = false
    @ObservedObject var appStateViewModel: AppState
    
    init(selectedLocation: DLocation, appStateViewModel: AppState) {
        self.selectedLocation = selectedLocation
        self.appStateViewModel = appStateViewModel
        self.ratingState = UserDefaults.standard.integer(forKey: selectedLocation.name.en)
        self.isFavorite = selectedLocation.isFavorite
        setup()
    }
    
    func setup() {
        self.locationRating = getRatingForLocation(location: selectedLocation)
    }
    
    func getRatingForLocation(location: DLocation) -> Rating {
        let rating = appStateViewModel.ratings.first { rating in
            rating.place == location.id
        }
        guard rating != nil else {
            return Rating(record: MockData.createMockRecord())
        }
        return rating!
        
    }
    
    func favoriteButtonTapped() {
        PersistanceManager.updateWith(favoriteId: selectedLocation.name.en, actionType: isFavorite ? .remove : .add) { result in
            switch result {
            case .success:
                self.isFavorite.toggle()
                self.handleRating()
            case .failure:
                print("could not add fav")
            }
        }
    }
    
    func handleRating() {
        if disableRating {
            return
        }
        
        switch ratingState {
        case 0:
            locationRating.rating += 1
            ratingState = 1
        case 1:
            locationRating.rating -= 1
            ratingState = 0
        default:
            print("not")
        }
        appStateViewModel.updateRatingForSelectedLocation(selectedLocation: selectedLocation,
                                                  rating: locationRating)
    }
    
}
