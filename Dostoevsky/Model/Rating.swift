//
//  Rating.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 05.03.22.
//

import CloudKit

enum RecordTypes{
    static let ratings = "Rating"
}

struct Rating: Identifiable, Hashable{

    enum Keys{
        static let rating = "rating"
        static let locationId = "locationId"
    }

    var id: CKRecord.ID
    var rating: Int
    var place: Int

    init(record: CKRecord){
        id = record.recordID
        rating = record[Rating.Keys.rating] as? Int ?? 0
        place = record[Rating.Keys.locationId] as? Int ?? 0
    }
}
