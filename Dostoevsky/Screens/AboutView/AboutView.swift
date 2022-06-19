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
  @State var result: Result<MFMailComposeResult, Error>?
    @State var isShowingMailView = false

    var body: some View {
      VStack(alignment: .leading) {

        Form {
            Section(result == nil ? L10n.About.Email.sectionheader : "\(String(describing: result))") {
            Button {
              self.isShowingMailView.toggle()
            } label: {
                Label(L10n.About.Email.action, systemImage: "envelope.badge")
            }.disabled(!MFMailComposeViewController.canSendMail())

          }

            Section(L10n.About.Useractions.sectionheader) {
            Button {
              SKStoreReviewController.requestReviewInCurrentScene()
            } label: {
                Label(L10n.About.Useractions.Action.rate, systemImage: "star")
            }
            Button {
              isShowingSheet = true
            } label: {
                Label(L10n.About.Useractions.Action.share, systemImage: "square.and.arrow.up")
            }

          }
        }
      }

      .sheet(isPresented: $isShowingMailView) {
                  MailView(result: self.$result)
              }
      .sheet(isPresented: $isShowingSheet, content: {
          ShareSheet(activityItems: [L10n.About.Useractions.Sharesheet.text +
                                     "https://apps.apple.com/app/dostoevskys-petersburg/id1614266132"])
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
