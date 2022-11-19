import SwiftUI
import StoreKit
import MessageUI

struct AboutView: View {
    @State var isShowingSheet = false
    @State var result: Result<MFMailComposeResult, Error>?
    @State var isShowingMailView = false
    @EnvironmentObject var viewModel: AppState
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Form {
                Section(L10n.About.Email.sectionheader) {
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
                        Label(L10n.About.Useractions.Action.rate, systemImage: "hand.thumbsup")
                    }
                    Button {
                        isShowingSheet = true
                    } label: {
                        Label(L10n.About.Useractions.Action.share, systemImage: "square.and.arrow.up")
                    }
                    Button {
                        viewModel.showBuyPremiumSheet.toggle()
                    } label: {
                        Label(L10n.About.buyPremium, systemImage: "star")
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
