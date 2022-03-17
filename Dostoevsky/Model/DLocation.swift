//
//  DOLocations.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 02.03.22.
//

import Foundation
import MapKit


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
  let location: String
  let address: Address
  let date: Address?
  let books: Books?
  
  var isFavorite: Bool{
    PersistanceManager.isFavorite(self)
  }
  
  var localizedDate: String?{
    isRussian() ? date?.ru : date?.en
  }
  
  var localizedName: String{
    isRussian() ? name.ru : name.en
  }
  
  var localizedBook: String?{
    isRussian() ? books?.ru.first : books?.en.first
  }
  
  
  var bookType: BookType?{
    guard self.books != nil else {
      return nil
    }
    if self.books!.en.hasName("Crime and Punishment"){
      return .crimeAndPunishment
    }else if self.books!.en.hasName("Humiliated and Insulted"){
      return .humiliatedAndInsulted
    }
    return nil
  }
  
  func getCLLocation()->CLLocation{
    let latLon = Array(location.replacingOccurrences(of: " ", with: "").split(separator: ",")).map({Double($0)!})
    return CLLocation(latitude: latLon[0], longitude: latLon[1])
  }
  
  var definedCategory: Categories{
    guard category < Categories.allCases.count+1 else{
      fatalError("tried to add category out of bounds")
    }
    return Categories.allCases[category-1]
  }
}

struct Address: Codable {
  let en, ru: String
}

struct Books: Codable {
  let en, ru: [String]
}

extension Collection where Element == DLocation{
  var beforeExileLocations: [DLocation]{
    self.filter{$0.definedCategory == Categories.beforeExile}
  }
  var afterExileLocations: [DLocation]{
    self.filter{$0.definedCategory == Categories.afterExile}
  }
  
  var biographyLocations: [DLocation]{
    self.beforeExileLocations + self.afterExileLocations
  }
  var novelLocations: [DLocation]{
    self.filter{$0.definedCategory == Categories.novels}
  }
  var crimeAndPunishmentLocations: [DLocation]{
    self.filter{
      return $0.books?.en.contains("Crime and Punishment") ?? false
    }
  }
  func novelFilteredLocations(for novelName: String)->[DLocation]{
    self.filter{
      return $0.books?.en.contains(novelName) ?? false
    }
  }
}
