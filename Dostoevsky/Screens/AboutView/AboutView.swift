//
//  AboutView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 14.03.22.
//

import SwiftUI
import StoreKit
import MessageUI

struct AboutView: View {
  @State var isShowingSheet = false
  @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var body: some View {
      VStack(alignment: .leading){
        
        Form{
          Section(result == nil ? "We missed something?" : "\(String(describing: result))"){
            Button {
              self.isShowingMailView.toggle()
            } label: {
              Label("E-mail us", systemImage: "envelope.badge")
            }.disabled(!MFMailComposeViewController.canSendMail())

          }
          
          Section("Spread the word"){
            Button {
              SKStoreReviewController.requestReviewInCurrentScene()
            } label: {
              Label("Rate App", systemImage: "star")
            }
            Button{
              isShowingSheet = true
            } label: {
              Label("Share App", systemImage: "square.and.arrow.up")
            }
            
          }
        }
      }
      
      .sheet(isPresented: $isShowingMailView) {
                  MailView(result: self.$result)
              }
      .sheet(isPresented: $isShowingSheet, content: {
        ShareSheet(activityItems: ["Check out this cool app! https://apps.apple.com/app/dostoevskys-petersburg/id1614266132"])
      })
      .accentColor(.white)
      
        .preferredColorScheme(.dark)
        
      
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
