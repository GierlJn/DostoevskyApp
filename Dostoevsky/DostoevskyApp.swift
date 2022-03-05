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
          AppTabView().environmentObject(AppStateViewModel())
            
        }
    }
}
