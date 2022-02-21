//
//  DostoevskyApp.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

@main
struct DostoevskyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                TabView{
                    NavigationView{
                        MainListView()
                    }.tabItem {
                        Label("Locations", systemImage: "person")
                    }
                    DMapview()
                        .tabItem{
                            Label("Map", systemImage: "map")
                        }
                }
                
            }
            
        }
    }
}
