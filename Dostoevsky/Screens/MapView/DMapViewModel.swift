//
//  LocationMapViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import MapKit

final class DMapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181, longitude: 30.338418), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Published var isShowingDetailView = false
    
    func getLocations(for locationManager: LocationManager){
        CloudKitManager.shared.getLocations { [self] result in
            DispatchQueue.main.async {
                switch(result){
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    print("error")
                }
            }
        }
    }
}
