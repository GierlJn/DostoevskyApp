//
//  DMapViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 06.03.22.
//

import SwiftUI
import MapKit

class DMapViewModel: NSObject, ObservableObject{
  @Published var filter: FilterOptions = .afterExile
  @Published var alertItem: AlertItem?
  var deviceLocationManager: CLLocationManager?
  
  func checkIfLocationServicesIsEnabled() {
    if CLLocationManager.locationServicesEnabled(){
      deviceLocationManager = CLLocationManager()
      deviceLocationManager?.delegate = self
    }else{
      alertItem = AlertContext.locationDisabled
    }
  }
  
  private func checkLocationAuthorization() {
    guard let deviceLocationManager = deviceLocationManager else {
      return
    }
    
    switch deviceLocationManager.authorizationStatus{
      
    case .notDetermined:
      deviceLocationManager.requestWhenInUseAuthorization()
    case .restricted:
      alertItem = AlertContext.locationRestricted
    case .denied:
      alertItem = AlertContext.locationDenied
    case .authorizedAlways, .authorizedWhenInUse:
      break
    @unknown default:
      break
    }

  }
}

extension DMapViewModel: CLLocationManagerDelegate{
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
}
