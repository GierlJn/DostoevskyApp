//
//  DOLocations.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 02.03.22.
//

import Foundation
import MapKit


struct DOLocation: Codable {
    let placeId: Int
    let name: Address
    let category: Int
    let description: Address
    let imageList: [String]
    let location: GeoLocation
    let address, date: Address

    func getCLLocation()->CLLocation{
        return CLLocation(latitude: Double(location.lat)!, longitude: Double(location.lon)!)
    }
}

// MARK: - Address
struct Address: Codable {
    let en, ru: String
}

// MARK: - LocationLocation
struct GeoLocation: Codable {
    let lat, lon: String
}
