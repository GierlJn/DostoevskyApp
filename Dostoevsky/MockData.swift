//
//  MockData.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import Foundation
import CloudKit
import SwiftUI

enum RecordTypes{
    static let location = "Location"
}

struct MockData{
    static func createLocationRecord()->CKRecord{
        let record = CKRecord(recordType: RecordTypes.location)
        record[DLocation.Keys.category] = 1
        record[DLocation.Keys.description] = "test description test description test description test description test description test description test description test description test description test description test description test description"
        record[DLocation.Keys.location] = CLLocation(latitude: 37, longitude: -121)
        record[DLocation.Keys.name] = "Red Palace"
        record[DLocation.Keys.place] = 1
        record[DLocation.Keys.previewImage] = UIImage(systemName: "person")?.convertToCKAsset()
        record[DLocation.Keys.streetName] = "Skt. Georgrn Str. 26"
        record[DLocation.Keys.time] = "May 4 1999"
        return record
    }
}

extension UIImage{
    func convertToCKAsset() -> CKAsset? {
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
        
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        do{
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        }catch{
            return nil
        }
    }
}
