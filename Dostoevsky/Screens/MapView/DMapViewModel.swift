import SwiftUI
import MapKit

class DMapViewModel: NSObject, ObservableObject {
    @Published var filter: FilterOptions = .beforeExile
    @Published var alertItem: AlertItem?
    let deviceLocationManager: CLLocationManager = CLLocationManager()
    
    func setupLocationDelegate() {
        if deviceLocationManager.delegate == nil {
            deviceLocationManager.delegate = self
        }
    }
    
    private func updateLocationServiceStatus() {
        switch deviceLocationManager.authorizationStatus {
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

extension DMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateLocationServiceStatus()
    }
}
