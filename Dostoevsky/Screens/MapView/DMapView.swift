//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit



struct DMapview: View{
    
    @EnvironmentObject var viewModel: AppStateViewModel
    @State var selectedLocation: DLocation?
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
                    MapAnnotation(coordinate: location.getCLLocation().coordinate) {
                        DAnnotation(viewModel: viewModel, location: location)
                            .onTapGesture {
                                selectedLocation = location
                                viewModel.isShowingDetailView = true
                            }
                    }
                }
            }
            
            VStack{
                Image("map-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .shadow(color: .black, radius: 12)
                    .padding()
                Spacer()
            }
            
        }
        
        
        .overlay( Picker("Filter", selection: $viewModel.filter) {
            Text("Show all").tag(FilterOptions.all)
            Text("Before exile").tag(FilterOptions.beforeExile)
            Text("After exile").tag(FilterOptions.afterExile)
            Text("Novels").tag(FilterOptions.novels)}
                    .frame(width: 100, height: 35).background(RoundedRectangle(cornerRadius: 12)
                                                                .foregroundColor(getFilterColor()))
                    .padding(6), alignment: .bottomTrailing)
        
        
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .accentColor(.white)
        
        .fullScreenCover(isPresented: $viewModel.isShowingDetailView, onDismiss: {}){
          LocationDetailView(locationDetailViewModel: LocationDetailViewModel(selectedLocation: self.selectedLocation!, appStateViewModel: viewModel)).environmentObject(viewModel)
        }
        
        
    }
    
    func getFilterColor()->Color{
        switch viewModel.filter{
        case .all:
            return Color.brandPrimary
        case .beforeExile:
            return Color.brandCategory1
        case .afterExile:
            return Color.brandCategory2
        case .novels:
            return Color.brandCategory3
        }
    }
}
