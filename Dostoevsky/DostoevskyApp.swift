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
      let appState = AppState()
        WindowGroup {
          if appState.showsOnboard{
            OnBoardView().environmentObject(appState)
          }else{
            AppTabView().environmentObject(appState)
          }
          
        }
    }
}
