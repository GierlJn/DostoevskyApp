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
            VStack{
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations.filter({ loc in
                    switch viewModel.filter{
                    case .all:
                        return true
                    case .beforeExile:
                        return loc.category == 1
                    case .afterExile:
                        return loc.category == 2
                    case .novels:
                        return loc.category == 3
                    }
                })) { location in
                    MapAnnotation(coordinate: location.location.coordinate) {
                        DAnnotation(location: location)
                            .onTapGesture {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            }
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
        
        
        .overlay( Picker("Filter", selection: $viewModel.filter) {
            Text("Show all").tag(FilterOptions.all)
            Text("Before exile").tag(FilterOptions.beforeExile)
            Text("After exile").tag(FilterOptions.afterExile)
            Text("Novels").tag(FilterOptions.novels)}.padding(), alignment: .bottomTrailing)
        
        
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .accentColor(.white)
        
        .fullScreenCover(isPresented: $viewModel.isShowingDetailView, onDismiss: {}){
            LocationDetailView(viewModel: viewModel)
        }
        
        
    }
}
