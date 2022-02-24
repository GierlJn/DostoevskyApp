//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View{
    
    @ObservedObject var viewModel = LocationDetailViewModel()

    var body: some View{
        ZStack{
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate) {
                    DAnnotation(location: location)
                        .onTapGesture {
                            viewModel.selectedLocation = location
                            viewModel.setup(location: location)
                            viewModel.isShowingDetailView = true
                    }
                }
            }
            VStack{
                Image("map-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .shadow(radius: 10)
                Spacer()
            }
            
        }
        
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .accentColor(.white)
        .sheet(isPresented: $viewModel.isShowingDetailView, onDismiss: {}){
            NavigationView{
                LocationDetailView(viewModel: viewModel)
            }
        }
        
        
    }
}
