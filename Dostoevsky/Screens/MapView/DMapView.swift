//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View{
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = DMapViewModel()

    var body: some View{
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
            MapAnnotation(coordinate: location.location.coordinate) {
                DAnnotation()
                    .onTapGesture {
                        locationManager.selectedLocation = location
                        viewModel.isShowingDetailView = true
                }
            }
        }
        .accentColor(.white)

        .sheet(isPresented: $viewModel.isShowingDetailView){
            LocationDetailView(viewModel: LocationDetailViewModel(location: locationManager.selectedLocation!))
        }
        .onAppear{
            if(locationManager.locations.isEmpty){
                viewModel.getLocations(for: locationManager)
            }
        }
        
    }
}
