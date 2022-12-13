import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        true
    }
}

public func isRussianLanguage() -> Bool {
    NSLocale.preferredLanguages[0].range(of: "ru") != nil
}

@main
struct DostoevskyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appState = AppState()
    var body: some Scene {
        WindowGroup {
            AppTabView().environmentObject(appState)
                .fullScreenCover(isPresented: $appState.showsOnboard) {
                    OnBoardView().environmentObject(appState)
                }
                .preferredColorScheme(.dark)
                .onAppear {
                    if CommandLine.arguments.contains("--UITests") {
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    }
                }
        }
    }
}
