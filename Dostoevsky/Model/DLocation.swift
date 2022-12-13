import Foundation
import MapKit

struct DLocation: Identifiable, Hashable, Codable {
    static var preview: DLocation = .init(id: 1, name: .init(en: "Preview address", ru: "Preview Address"), category: 1, description: .init(en: "Preview address", ru: "Preview Address"), imageList: [], location: "Preview location", address: .init(en: "address", ru: "address"), date: .init(en: "address", ru: "address"), books: nil)
    
    static func == (lhs: DLocation, rhs: DLocation) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: Int
    let name: Address
    let category: Int
    let description: Address
    let imageList: [String]
    let location: String
    let address: Address
    let date: Address?
    let books: Books?

    var isFavorite: Bool {
        PersistanceManager.isFavorite(self)
    }

    var localizedDescription: String {
        isRussianLanguage() ? description.ru : description.en
    }

    var localizedAddress: String {
        isRussianLanguage() ? address.ru : address.en
    }

    var localizedDate: String? {
        isRussianLanguage() ? date?.ru : date?.en
    }

    var localizedName: String {
        isRussianLanguage() ? name.ru : name.en
    }

    var localizedBook: String? {
        isRussianLanguage() ? books?.ru.first : books?.en.first
    }

    var bookType: BookType? {
        guard books != nil else {
            return nil
        }
        if books!.en.hasName("Crime and Punishment") {
            return .crimeAndPunishment
        } else if books!.en.hasName("Humiliated and Insulted") {
            return .humiliatedAndInsulted
        }
        return nil
    }

    func getCLLocation() -> CLLocation {
        let latLon = Array(location.replacingOccurrences(of: " ", with: "").split(separator: ",")).map({ Double($0)! })
        return CLLocation(latitude: latLon[0], longitude: latLon[1])
    }

    var definedCategory: Categories {
        guard category < Categories.allCases.count + 1 else {
            fatalError("tried to add category out of bounds")
        }
        return Categories.allCases[category - 1]
    }
}

struct Address: Codable {
    let en, ru: String
}

struct Books: Codable {
    let en, ru: [String]
}

extension Collection<DLocation> {
    var beforeExileLocations: [DLocation] {
        filter { $0.definedCategory == Categories.beforeExile }
    }

    var afterExileLocations: [DLocation] {
        filter { $0.definedCategory == Categories.afterExile }
    }

    var biographyLocations: [DLocation] {
        beforeExileLocations + afterExileLocations
    }

    var novelLocations: [DLocation] {
        filter { $0.definedCategory == Categories.novels }
    }

    var crimeAndPunishmentLocations: [DLocation] {
        filter {
            $0.books?.en.contains("Crime and Punishment") ?? false
        }
    }

    func novelFilteredLocations(for novelName: String) -> [DLocation] {
        filter {
            $0.books?.en.contains(novelName) ?? false
        }
    }
}
