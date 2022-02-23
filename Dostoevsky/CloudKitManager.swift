//
//  CloudKitManager.swift
//  Grab
//
//  Created by Julian Gierl on 25.08.21.
//

import CloudKit

final class CloudKitManager{
    
    static var shared = CloudKitManager()
    
    private init(){}
    
    func getLocations(completed: @escaping (Result<[DLocation], Error>) -> Void){
        let orderSort = NSSortDescriptor(key: DLocation.Keys.place, ascending: true)
        let query = CKQuery(recordType: RecordTypes.location, predicate: NSPredicate(value: true))
        //query.sortDescriptors = [orderSort]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            
            let locations = records.map { DLocation(record: $0) }
            completed(.success(locations))
        }
    }
    
    
    func save(record: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void){
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
            return
        }
    }
    
    func fetchRecord(with id: CKRecord.ID, completed: @escaping (Result<CKRecord, Error>) -> Void){
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
            return
        }
    }
}
