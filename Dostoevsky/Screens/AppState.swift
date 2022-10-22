import MapKit
import CloudKit
import SwiftUI
import StoreKit

enum SortType: CaseIterable {
    case date, rating, favorite
}

enum ActiveStatus: String, CaseIterable, Identifiable {
    case active
    case inactive
    
    var id: String { self.rawValue }
}

extension Collection where Element == String {
    func hasName(_ id: String) -> Bool {
        self.contains(where: { $0 == "\(id)"})
    }
}

public enum StoreError: Error {
    case failedVerification
}

class AppState: ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181,
                                                                              longitude: 30.338418),
                                               span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Published var showDetail: ActiveStatus?
    @Published var locations = [DLocation]()
    @Published var ratings = [Rating]()
    
    @Published var isLoadingData = false
    @Published var sort: SortType = .date
    @Published var showingFavorites = false
    @Published var selectedLocation: DLocation?
    @Published var showCompatListVIew = false
    
    @AppStorage("onboard") var showsOnboard = true
    
    @Published private(set) var subscription: Product?
    @Published private(set) var purchasedSubscription: Product?
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    init() {
        updateListenerTask = listenForTransactions()

        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //Iterate through any transactions that don't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                } catch {
                    //StoreKit has a transaction that fails verification. Don't deliver content to the user.
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: ["dostoevsky.premium"])
            guard let premiumProduct = storeProducts.first else {
                return
            }

            subscription = premiumProduct
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                //Check whether the transaction is verified. If it isn’t, catch `failedVerification` error.
                let transaction = try checkVerified(result)

                if subscription?.id == transaction.productID {
                    purchasedSubscription = subscription
                }
            } catch {
                print(error)
            }
        }
    }
    
    func purchase(_ product: Product) async throws -> StoreKit.Transaction? {
        //Begin purchasing the `Product` the user selects.
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            //Check whether the transaction is verified. If it isn't,
            //this function rethrows the verification error.
            let transaction = try checkVerified(verification)

            //The transaction is verified. Deliver content to the user.
            await updateCustomerProductStatus()

            //Always finish a transaction.
            await transaction.finish()

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    var isSubscriptionPurchased: Bool {
        purchasedSubscription == subscription
    }

    func isPurchased(_ product: Product) async throws -> Bool {
        //Determine whether the user purchases a given product.
        purchasedSubscription == subscription
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }
    
    func getRatingForLocation(location: DLocation) -> Rating {
        let rating = ratings.first { rating in
            rating.place == location.id
        }
        guard rating != nil else {
            return Rating(record: MockData.createMockRecord())
        }
        return rating!
    }
    
    func updateRatingForSelectedLocation(selectedLocation: DLocation, rating: Rating) {
        ratings.removeAll { $0.id == rating.id}
        ratings.append(rating)
        CloudKitManager.shared.fetchRecordN(with: selectedLocation.id) { result in
            switch result {
            case .success(let record):
                record["rating"] = rating.rating
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
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
        self.locations = Bundle.main.decode([DLocation].self, from: "locations.json")
        CloudKitManager.shared.getLocationRatings { [self] result in
            DispatchQueue.main.async {
                self.isLoadingData = false
                switch result {
                case .success(let ratings):
                    self.ratings = ratings
                case .failure:
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
