//
//  DOLocations.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 02.03.22.
//

import Foundation
import MapKit

struct DOLocation: Codable {
    let placeID: Int
    let name: Address
    let category: Int
    let locationDescription: Address
    let images: [ImageId]
    let location: GeoLocation
    let address, date: Address

    enum CodingKeys: String, CodingKey {
        case placeID = "placeId"
        case name, category
        case locationDescription = "description"
        case images, location, address, date
    }
    
    func getCLLocation()->CLLocation{
        return CLLocation(latitude: Double(location.lat)!, longitude: Double(location.lon)!)
    }
}


// MARK: - Address
struct Address: Codable {
    let en, ru: String
}

// MARK: - Image
struct ImageId: Codable {
    let imageName: String
}

// MARK: - LocationLocation
struct GeoLocation: Codable {
    let lat, lon: String
}
