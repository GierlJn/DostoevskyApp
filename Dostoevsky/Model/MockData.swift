
import Foundation
import CloudKit

struct MockData{
    static func createMockRecord()->CKRecord{
        let record = CKRecord(recordType: RecordTypes.ratings)
        record[Rating.Keys.rating] = 1
        return record
    }
}
