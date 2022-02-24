//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View{
    
    //@EnvironmentObject private var locationManager: LocationManager
    @StateObject var viewModel = LocationDetailViewModel()

    var body: some View{
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.location.coordinate) {
                DAnnotation()
                    .onTapGesture {
                        viewModel.selectedLocation = location
                        viewModel.setup(location: location)
                        viewModel.isShowingDetailView = true
                }
            }
        }
        .accentColor(.white)

        .sheet(isPresented: $viewModel.isShowingDetailView, onDismiss: {}){
            NavigationView{
                LocationDetailView(viewModel: viewModel)
            }
        }
        .onAppear{
            if(viewModel.locations.isEmpty){
                viewModel.getLocations()
            }
        }
        
    }
}
