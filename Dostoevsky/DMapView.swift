//
//  DMapView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.02.22.
//

import SwiftUI
import MapKit

struct DMapview: View{
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.933181, longitude: 30.338418), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State var locations = [DLocation(record: MockData.createLocationRecord()), DLocation(record: MockData.createLocationRecord()), DLocation(record: MockData.createLocationRecord())]
    
    var body: some View{
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.location.coordinate) {
                DAnnotation().onTapGesture {
                    print("click")
                }
            }
            
//            AnyMapAnnotationProtocol(MapAnnotation(coordinate: location.location.coordinate) {
//                    Image("dostoAnno")
//                        .resizable()
//                        .frame(width: 45, height: 70)
//                            .onTapGesture {
//                                print("Test tapping")
//                            }
//                        })
//
            
            
        }.onAppear(perform: {
            CloudKitManager.shared.getLocations { result in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let locations):
                        self.locations = locations
                    }
                }
                
            }
        })
    }
    
}

//struct AnyMapAnnotationProtocol: MapAnnotationProtocol {
//  let _annotationData: _MapAnnotationData
//  let value: Any
//
//  init<WrappedType: MapAnnotationProtocol>(_ value: WrappedType) {
//    self.value = value
//    _annotationData = value._annotationData
//  }
//}
