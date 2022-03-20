//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View{
  
  @EnvironmentObject var viewModel: AppState
  @StateObject var mapViewModel = DMapViewModel()
  @State var numberOfPeople = 0
  
  var body: some View{
    ZStack{
      VStack{
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations.filter({ loc in
          switch mapViewModel.filter{
          case .all:
            return true
          case .beforeExile:
            return loc.category == 1
          case .afterExile:
            return loc.category == 2
          case .crime:
            return loc.bookType == .crimeAndPunishment
          case .humililated:
            return loc.bookType == .humiliatedAndInsulted
          }
        })) { location in
          MapAnnotation(coordinate: location.getCLLocation().coordinate) {
            DAnnotation(location: location)
              .onTapGesture {
                viewModel.selectedLocation = location
                viewModel.showDetail = ActiveStatus.active
              }
          }
        }
      }
      
//      VStack{
//          Image("sign")
//            .resizable()
//            .scaledToFit()
//            .frame(width: 150, height: 80)
//            .padding()
//            .shadow(radius: 12)
//            .shadow(radius: 12)
//
//        Spacer()
//      }
    }

    .overlay(PickerView(viewModel: mapViewModel), alignment: .bottomTrailing)
    .edgesIgnoringSafeArea([.top, .leading, .trailing])
    .accentColor(.white)

  }
  
  
}

extension View {
    func multicolorGlow() -> some View {
        ZStack {
            ForEach(0..<2) { i in
                Rectangle()
                    .fill(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center))
                    .frame(width: 150, height: 80)
                    .mask(self.blur(radius: 20))
                    .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
            }
        }
    }
}

struct PickerView: View{
  @StateObject var viewModel: DMapViewModel
  var body: some View{
    Picker("Filter", selection: $viewModel.filter) {
      Text("Show all").tag(FilterOptions.all)
      Text("Before exile").tag(FilterOptions.beforeExile)
      Text("After exile").tag(FilterOptions.afterExile)
      Text("Crime and Punishment").tag(FilterOptions.crime)
      Text("Humiliated and Insulted").tag(FilterOptions.humililated)}
    .padding(.horizontal)
    .background(RoundedRectangle(cornerRadius: 12)
      .foregroundColor(.accentLight))
    .padding(6)
  }
}
