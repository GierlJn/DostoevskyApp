//
//  DLocations.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import CloudKit
import UIKit

struct DLocation: Identifiable, Hashable{
    
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
    }
    
    var id: CKRecord.ID
    var category: Int
    var description: String
    var location: CLLocation
    var name: String
    var place: Int
    var previewImage: CKAsset!
    var streetName: String
    var time: String
    var rating: Int
    
    init(record: CKRecord){
        id = record.recordID
        category = record[DLocation.Keys.category] as? Int ?? 0
        description = record[DLocation.Keys.description] as? String ?? ""
        location = record[DLocation.Keys.location] as? CLLocation ?? CLLocation()
        name = record[DLocation.Keys.name] as? String ?? ""
        place = record[DLocation.Keys.place] as? Int ?? 0
        previewImage = record[DLocation.Keys.previewImage] as? CKAsset
        streetName = record[DLocation.Keys.streetName] as? String ?? ""
        time = record[DLocation.Keys.time] as? String ?? ""
        rating = record[DLocation.Keys.rating] as? Int ?? 0
    }
    
    func createBannerImage() -> UIImage{
        guard let asset = previewImage else { return PlaceholderImage.banner }
        return asset.convertToUIImage()
    }
    
}


