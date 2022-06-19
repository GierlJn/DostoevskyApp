//
//  AppTabView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import SwiftUI

struct AppTabView: View {
    
    @EnvironmentObject var viewModel: AppState
    @State var buttonPressed = false
    var body: some View {
        TabView{
            ZStack{
                Group{
                    if viewModel.showCompatListVIew{
                        MainListView()
                    }else{
                        TimeLineView()
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            viewModel.showCompatListVIew.toggle()
                            withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)){
                                buttonPressed.toggle()
                            }
                        } label: {
                            AnimatedListButton(isRotating: $buttonPressed, isHidden: $buttonPressed)
                        }
                        .padding()
                    }}
                
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .tabItem {
                Label(L10n.Tabbar.Label.biography, systemImage: "building")
            }
            
            BookOverViewList()
                .tabItem {
                    Label(L10n.Tabbar.Label.books, systemImage: "book")
                        .accessibilityIdentifier(AccessibilityIdentifier.books)
                }
            
            DMapview()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .tabItem {
                    Label(L10n.Tabbar.Label.map, systemImage: "map")
                        .accessibilityIdentifier(AccessibilityIdentifier.map)
                }
            AboutView()
                .tabItem {
                    Label(L10n.Tabbar.Label.about, systemImage: "info")
                }
            
            
        }
        .accessibilityIdentifier(AccessibilityIdentifier.tabBar)
        .onAppear{
            if(viewModel.locations.isEmpty){
                viewModel.setup()
            }
        }
        .accentColor(.customAccentColor)
        .overlay(viewModel.isLoadingData ? LoadingView() : nil)
        .sheet(item: $viewModel.showDetail, content: { _ in
            LocationDetailView(locationDetailViewModel: LocationDetailViewModel(selectedLocation: viewModel.selectedLocation!, appStateViewModel: viewModel))
        })
        
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

