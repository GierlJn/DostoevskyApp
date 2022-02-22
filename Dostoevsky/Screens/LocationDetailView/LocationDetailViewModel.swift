//
//  LocationDetailViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import Foundation

class LocationDetailViewModel: ObservableObject{
    var location: DLocation
    init(location: DLocation) {
        self.location = location
    }
}
