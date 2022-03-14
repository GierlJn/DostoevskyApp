//
//  DostoevskyApp.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

@main
struct DostoevskyApp: App {
  @StateObject var appState = AppState()
    var body: some Scene {
        WindowGroup {
          AppTabView().environmentObject(appState)
            .preferredColorScheme(.dark)
//          if appState.showsOnboard{
//            OnBoardView().environmentObject(appState)
//          }else{
//            AppTabView().environmentObject(appState)
//          }
          
        }
    }
}
