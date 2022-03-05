//
//  DOLocations.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 02.03.22.
//

import Foundation
import MapKit



struct DLocation: Identifiable, Hashable, Codable {
    static func == (lhs: DLocation, rhs: DLocation) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher)
        {
            hasher.combine(id)
        }
    let id: Int
    let name: Address
    let category: Int
    let description: Address
    let imageList: [String]
    let location: GeoLocation
    let address, date: Address

    func getCLLocation()->CLLocation{
        return CLLocation(latitude: Double.initFromCommaString(str: location.lat), longitude: Double.initFromCommaString(str: location.lon))
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

extension UIImage{
    static func loadImages(_ imageNames: [String])->[UIImage]{
        var images = [UIImage]()
        for name in imageNames{
            if let image = UIImage(named: name){
                images.append(image)
            }
        }
        return images
    }
}
