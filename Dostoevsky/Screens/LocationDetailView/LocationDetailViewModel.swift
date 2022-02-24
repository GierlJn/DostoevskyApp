//
//  LocationDetailViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import MapKit
import CloudKit

class LocationDetailViewModel: ObservableObject{
    
    @Published var selectedLocation: DLocation?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181, longitude: 30.338418), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Published var isShowingDetailView = false
    @Published var locations = [DLocation]()
    @Published var ratingState = 0{
        didSet{
            guard let selectedLocation = selectedLocation else {
                return
            }
            UserDefaults.standard.set(ratingState, forKey: selectedLocation.name)
        }
    }
    @Published var disableRating = false
    
    
    func setup(location: DLocation) {
        self.selectedLocation = location
        self.ratingState = UserDefaults.standard.integer(forKey: location.name)
    }
    
    func getLocations(){
        CloudKitManager.shared.getLocations { [self] result in
            DispatchQueue.main.async {
                switch(result){
                case .success(let locations):
                    self.locations = locations
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
        
        let placemark = MKPlacemark(coordinate: selectedLocation.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = selectedLocation.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    func updateLocationRating(){
        guard let selectedLocation = selectedLocation else {
            return
        }
        disableRating = true
 
        CloudKitManager.shared.fetchRecord(with: selectedLocation.id) { [self] result in
            switch result{
            case .success(let record):
                record[DLocation.Keys.rating] = selectedLocation.rating
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async {
                        switch result{

                        case .success(let record):
                            self.selectedLocation = DLocation(record: record)
                            print("success")
                        case .failure(let error):
                            print(error)
                        }
                        disableRating = false
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateSelectedLocation(){
        guard let selectedLocation = selectedLocation else {
            return
        }
        let oldLocationIndex = locations.firstIndex { loc in loc.id == selectedLocation.id }
        guard let idx = oldLocationIndex else {
            return
        }
        locations[idx] = selectedLocation
    }
    

}
