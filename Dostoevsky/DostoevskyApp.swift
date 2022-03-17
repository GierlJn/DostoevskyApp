//
//  DostoevskyApp.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI


public func isRussian() -> Bool {
    return NSLocale.preferredLanguages[0].range(of:"ru") != nil
}

@main
struct DostoevskyApp: App {
  @StateObject var appState = AppState()
  var body: some Scene {
    WindowGroup {
      Group{
        if appState.showsOnboard{
          OnBoardView().environmentObject(appState)
        }else{
          AppTabView().environmentObject(appState)
        }
      }.preferredColorScheme(.dark)
        
    }
  }
}
