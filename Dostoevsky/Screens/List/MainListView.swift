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
                    Button {
                        viewModel.showingFavorites.toggle()
                    } label: {
                        Text(viewModel.showingFavorites ? "Show all" : "Show favorites")
                    }

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
                        ForEach(beforeExileLocations, id: (\.self)){ location in
                            Button {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            } label: {
                                LocationCell(viewModel: viewModel, location: location)
                            }
                            
                        }
                    }
                    Section(header: HStack{
                        Text("After Exile")
                        
                    }){
                        ForEach(afterExileLocations, id: (\.self)){ location in
                            Button {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            } label: {
                                LocationCell(viewModel: viewModel, location: location)
                            }
                            
                        }
                    }
                    Section(header: HStack{
                        Text("Novels")
                        
                    }){
                        ForEach(novelLocations, id: (\.self)){ location in
                            Button {
                                viewModel.selectedLocation = location
                                viewModel.setup(location: location)
                                viewModel.isShowingDetailView = true
                            } label: {
                                LocationCell(viewModel: viewModel, location: location)
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
    
    var beforeExileLocations: [DLocation]{
        viewModel.showingFavorites ? viewModel.locations.filter{$0.category == 1}.filter({ loc in
            viewModel.favoriteIds.contains("\(loc.name)")
        }) : viewModel.locations.filter{$0.category == 1}
        
    }
    
    var afterExileLocations: [DLocation]{
        viewModel.showingFavorites ? viewModel.locations.filter{$0.category == 2}.filter({ loc in
            viewModel.favoriteIds.contains("\(loc.name)")
        }) : viewModel.locations.filter{$0.category == 2}
    }
    
    var novelLocations: [DLocation]{
        viewModel.showingFavorites ? viewModel.locations.filter{$0.category == 3}.filter({ loc in
            viewModel.favoriteIds.contains("\(loc.name)")
        }) : viewModel.locations.filter{$0.category == 3 }
    }

}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView(viewModel: LocationDetailViewModel())
    }
}


