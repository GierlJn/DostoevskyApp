//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI



struct MainListView: View {
    
    @ObservedObject var viewModel = LocationDetailViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    Button("Sort"){
                        print("test")
                    }
                }
                List{
                    Section(header: HStack{
                        Text("Novels")
                        
                    }){
                        ForEach(viewModel.locations.filter{$0.category == 1}, id: (\.self)){ location in
                            NavigationLink {
                                LocationDetailPushView(viewModel: viewModel, selectedLocation: location)
                            } label: {
                                LocationCell(location: location)
                            }
                        }
                    }
                }
                
            }
            
            
            .navigationBarHidden(true)
        }
        
        .accentColor(.white)
    }

}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}


