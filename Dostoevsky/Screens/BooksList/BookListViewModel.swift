import Foundation

class BookListViewModel: ObservableObject {
    func sortLocations(locations: [DLocation], sortType: SortType, appState: AppState) -> [DLocation] {
        switch sortType {
        case .date:
            return locations.sorted(by: { $0.id < $1.id })
        case .rating:
            return locations.sorted(by: { appState.getRatingForLocation(location: $0).rating > appState.getRatingForLocation(location: $1).rating })
        case .favorite:
            return locations.sorted(by: { item1, item2 -> Bool in
                var check1: Int = 0
                var check2: Int = 0
                if item1.isFavorite == true {
                    check1 = 1
                }
                if item2.isFavorite == true {
                    check2 = 1
                }
                return check1 > check2
            }
            )
        }
    }
}
