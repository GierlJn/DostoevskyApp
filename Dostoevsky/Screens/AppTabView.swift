import SwiftUI

struct AppTabView: View {

    @EnvironmentObject var viewModel: AppState
    @State var buttonPressed = false
    var body: some View {
        TabView {
            TimeLineView().environmentObject(viewModel)
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
                    LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
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
        .sheet(isPresented: $viewModel.showBuyPremiumSheet, content: {
            BuyPremiumView()
        })
        .accentColor(.orange)
        .overlay(viewModel.isLoadingData ? LoadingView() : nil)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(AppState())
    }
}
