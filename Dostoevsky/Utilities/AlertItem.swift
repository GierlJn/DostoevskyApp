//
//  AlertItem.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 23.03.22.
//

import SwiftUI

struct AlertItem: Identifiable{
  let id = UUID()
  let title: Text
  let message: Text
  let dismiss: Alert.Button
}


struct AlertContext{
  static let unableToGetLocations = AlertItem(title: Text("Locations Error"), message: Text("Unable to retrieve locations at this time. \n Please try again."), dismiss: .default(Text("Ok")))
  
  static let locationRestricted = AlertItem(title: Text("Locations Restricted"), message: Text("Your location is restricted."), dismiss: .default(Text("Ok")))
  
  static let locationDenied = AlertItem(title: Text("Locations Denied"), message: Text("The app has no permission to access your location. \nYou can change that in your phones settings."), dismiss: .default(Text("Ok")))
  
  static let locationDisabled = AlertItem(title: Text("Locations Disabled"), message: Text("Your phones location services are disabled. \nYou can change that in your phones settings."), dismiss: .default(Text("Ok")))
}
