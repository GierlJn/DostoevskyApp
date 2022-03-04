//
//  DOLocations.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 02.03.22.
//

import Foundation
import MapKit

    enum Keys{
        static let category = "category"
        static let description = "description"
        static let location = "location"
        static let name = "name"
        static let place = "place"
        static let previewImage = "previewImage"
        static let streetName = "streetName"
        static let time = "time"
        static let rating = "rating"
        static let imageNameList = "imageNameList"
    }

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

extension Double{
    static func initFromCommaString(str: String)->Double{
        Double(str.split(separator: ",").joined(separator: ".")) ?? 0
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
