//
//  LocationDetailViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import MapKit
import CloudKit

class LocationDetailViewModel: ObservableObject{
    @Published var location: DLocation
    init(location: DLocation) {
        self.location = location
    }
    
    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    func updateLocationRating(){
        CloudKitManager.shared.fetchRecord(with: location.id) { [self] result in
            switch result{
            case .success(let record):
                record[DLocation.Keys.rating] = location.rating
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let record):
                            self.location = DLocation(record: record)
                            print("success")
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
    
    //    CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
    //        switch result {
    //            case .success(let record):
    //                switch checkInStatus {
    //                    case .checkedIn:
    //                        record[DDGProfile.Keys.isCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
    //                        record[DDGProfile.Keys.isCheckedInNilCheck] = 1
    //                    case .checkedOut:
    //                        record[DDGProfile.Keys.isCheckedIn] = nil
    //                        record[DDGProfile.Keys.isCheckedInNilCheck] = nil
    //                }
    //
    //                CloudKitManager.shared.save(record: record) { result in
    //                    DispatchQueue.main.async {
    //                        switch result {
    //                            case .success(let record):
    //                                let profile = DDGProfile(record: record)
    //                                switch checkInStatus {
    //                                    case .checkedIn:
    //                                        checkedInProfiles.append(profile)
    //                                    case .checkedOut:
    //                                        checkedInProfiles.removeAll(where:{ $0.id == profile.id })
    //                                }
    //
    //                                isCheckedIn = checkInStatus == .checkedIn
    //
    //                            case .failure(_):
    //                                alertItem = AlertContext.invalidProfile
    //                        }
    //                    }
    //                }
    //
    //            case .failure(_):
    //                alertItem = AlertContext.invalidProfile
    //        }
    //    }
    
    
    
}
