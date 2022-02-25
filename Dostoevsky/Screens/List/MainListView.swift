//
//  MainListView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI



struct MainListView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        
            VStack{
                HStack{
                    Spacer()
                    
                    Spacer()
                    
                    Text("Sort by: ")
                    Picker("Sort", selection: $viewModel.sort) {
                        Text("Date").tag(SortType.date)
                        Text("Rating").tag(SortType.rating)
                    }

                    
                    
                }
                .padding(.top)
                .padding(.trailing)
                List{
                    Section(header: HStack{
                        Text("Before Exile")
                        
                    }){
                        ForEach(viewModel.locations.filter{$0.category == 1}, id: (\.self)){ location in
                            Button {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            } label: {
                                LocationCell(location: location)
                            }
                            
                        }
                    }
                    Section(header: HStack{
                        Text("After Exile")
                        
                    }){
                        ForEach(viewModel.locations.filter{$0.category == 2}, id: (\.self)){ location in
                            Button {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            } label: {
                                LocationCell(location: location)
                            }
                            
                        }
                    }
                    Section(header: HStack{
                        Text("Novels")
                        
                    }){
                        ForEach(viewModel.locations.filter{$0.category == 3}, id: (\.self)){ location in
                            Button {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            } label: {
                                LocationCell(location: location)
                            }
                            
                        }
                    }
                }
                Spacer()
                
            }
            .fullScreenCover(isPresented: $viewModel.isShowingDetailView){
                    LocationDetailView(viewModel: viewModel)
            }
            .navigationBarHidden(true)
            .navigationTitle("asdf")
            
            
        
        .accentColor(.white)
    }

}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView(viewModel: LocationDetailViewModel())
    }
}


