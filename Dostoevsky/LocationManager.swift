//
//  LocationManager.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

final class LocationManager: ObservableObject{
    @Published var locations = [DLocation]()
    var selectedLocation: DLocation?
}
