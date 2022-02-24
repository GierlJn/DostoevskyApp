//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

struct MainListView: View {
    
    @State var locations = [DLocation(record: MockData.createLocationRecord()), DLocation(record: MockData.createLocationRecord()), DLocation(record: MockData.createLocationRecord())]
    
    var body: some View {
        List{
            ForEach(locations, id: (\.self)){ location in
                NavigationLink(
                    destination: LocationDetailView(viewModel: LocationDetailViewModel()),
                    label: {
                        LocationCell(location: location)
                    })
                
            }
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

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
