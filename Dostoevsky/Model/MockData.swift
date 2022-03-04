//
//  MockData.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//
//
import Foundation
import CloudKit
//import SwiftUI
//
enum RecordTypes{
    static let location = "Location"
}
//
struct MockData{
    static func createMockRecord()->CKRecord{
        let record = CKRecord(recordType: RecordTypes.location)
        record[Keys.rating] = 1
        return record
    }
}
//
//extension UIImage{
//    func convertToCKAsset() -> CKAsset? {
//        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            return nil
//        }
//        
//        let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
//        
//        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
//        
//        do{
//            try imageData.write(to: fileUrl)
//            return CKAsset(fileURL: fileUrl)
//        }catch{
//            return nil
//        }
//    }
//}
