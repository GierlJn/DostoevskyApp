//
//  DostoevskyApp.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if CommandLine.arguments.contains("--UITests") {
          print("isuitest")
          }
        return true
    }
}

public func isRussian() -> Bool {
    return NSLocale.preferredLanguages[0].range(of:"ru") != nil
}

@main
struct DostoevskyApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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
        .onAppear{
          if CommandLine.arguments.contains("--UITests") {
          UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
          }
        }
    }
  }
}
