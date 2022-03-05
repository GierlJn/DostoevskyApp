

import CloudKit

final class CloudKitManager{
    
    static var shared = CloudKitManager()
    
    private init(){}
    
    func getLocationRatings(completed: @escaping (Result<[Rating], Error>) -> Void){
        let orderSort = NSSortDescriptor(key: "place", ascending: true)
        let query = CKQuery(recordType: "Location", predicate: NSPredicate(value: true))
        //query.sortDescriptors = [orderSort]

        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in

            guard error == nil else {
                completed(.failure(error!))
                return
            }

            guard let records = records else { return }

            let locations = records.map { Rating(record: $0) }
            
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
    
    func fetchRecordN(with placeId: Int, completed: @escaping (Result<CKRecord, Error>) -> Void){
        
        let predicate = NSPredicate(format: "place == \(placeId)")
        let query = CKQuery(recordType: "Location", predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.fetch(withQuery: query) { result in
            switch result{
            case .success((let matchResults, let queryCursor)):
                guard let matchRecordResult = matchResults.first else{
                    //completed(.failure(Error))
                    return
                }
                switch matchRecordResult.1{
                case .success(let record):
                    completed(.success(record))
                case .failure(let error):
                    completed(.failure(error))
                }
                return
            case .failure(let error):
                completed(.failure(error))
                return
            }
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
