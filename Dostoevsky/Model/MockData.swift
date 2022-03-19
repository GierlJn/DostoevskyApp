
import Foundation
import CloudKit

struct MockData{
    static func createMockRecord()->CKRecord{
        let record = CKRecord(recordType: RecordTypes.ratings)
        record[Rating.Keys.rating] = 1
        return record
    }
  
  static func createMockLocation()->DLocation{
    DLocation(id: 1,
              name: Address(en: "St. Pauli 213", ru: "St. Pauli 213"),
              category: 1, description: Address(en: "St. Pauli 213 St. Pauli 213 St. Pauli 213 St. Pauli 213",
                                                ru: "St. Pauli 213 St. Pauli 213 St. Pauli 213 St. Pauli 213"),
              imageList: ["10"], location: "59.926738, 30.311942",
              address: Address(en: "Kaznacheyskaya Ulitsa, 7",
                               ru: "Казначейская улица, 7"),
              date: Address(en: "April 1864", ru: "Апрель 1864"),
              books: nil)
  }
}
