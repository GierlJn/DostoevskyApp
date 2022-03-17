//
//  SubImageLabels.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 17.03.22.
//

import SwiftUI
import MapKit

struct SubImageLabels: View {
  var location: DLocation
  
  var body: some View {
    VStack(spacing: 8){
      HStack {
        Button {
          getDirectionsToLocation(location: location)
        } label: {
          AddressView(address: location.localizedAddress)
        }
        Spacer()
      }
      
      if let date = location.localizedDate{
        HStack {
          DateView(date: date)
          Spacer()
        }
      }
    }.padding(.horizontal)
  }
  
  private struct AddressView: View {
    
    var address: String
    
    var body: some View {
      Label(address, systemImage: "mappin.and.ellipse")
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }

  private struct DateView: View {
    
    var date: String
    
    var body: some View {
      Label(date, systemImage: "calendar")
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }

  
  func getDirectionsToLocation(location: DLocation) {
    let placemark = MKPlacemark(coordinate: location.getCLLocation().coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = location.localizedName
    
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
  }
  
}


struct SubImageLabels_Previews: PreviewProvider {
    static var previews: some View {
      SubImageLabels(location: MockData.createMockLocation())
    }
}
