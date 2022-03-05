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
  
  func getCLLocation()->CLLocation{
    
    let latLon = Array(location.replacingOccurrences(of: " ", with: "").split(separator: ",")).map({Double($0)!})
    return CLLocation(latitude: latLon[0], longitude: latLon[1])
  }
}

struct Address: Codable {
  let en, ru: String
}
