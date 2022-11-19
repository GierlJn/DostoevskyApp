import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismiss: Alert.Button
}

struct AlertContext {
    static let unableToGetLocations = AlertItem(title: Text(L10n.Alerts.UnableToGetLocations.title),
                                                message: Text(L10n.Alerts.UnableToGetLocations.message),
                                                dismiss: .default(Text(L10n.General.dismissButton)))
    
    static let locationRestricted = AlertItem(title: Text(L10n.Alerts.LocationRestricted.title),
                                              message: Text(L10n.Alerts.LocationRestricted.message),
                                              dismiss: .default(Text(L10n.General.dismissButton)))
    
    static let locationDenied = AlertItem(title: Text(L10n.Alerts.LocationDenied.title),
                                          message: Text(L10n.Alerts.LocationDenied.message),
                                          dismiss: .default(Text(L10n.General.dismissButton)))
    
    static let locationDisabled = AlertItem(title: Text(L10n.Alerts.LocationDisabled.title),
                                            message: Text(L10n.Alerts.LocationDisabled.message),
                                            dismiss: .default(Text(L10n.General.dismissButton)))
}

extension AlertContext {
    static let premiumPurchased = AlertItem(title: Text(L10n.Alerts.PremiumPurchased.title), message: Text(L10n.Alerts.PremiumPurchased.message), dismiss: .default(Text(L10n.General.dismissButton)))
    
    static let failedVerification = AlertItem(title: Text(L10n.Alerts.PurchasedFailed.title), message: Text(L10n.Alerts.FailedVerification.message), dismiss: .default(Text(L10n.General.dismissButton)))
    
    static let pending = AlertItem(title: Text(L10n.Alerts.PurchasedFailed.title), message: Text(L10n.Alerts.Pending.message), dismiss: .default(Text(L10n.General.dismissButton)))
    
    static let defaultPurchaseError = AlertItem(title: Text(L10n.Alerts.PurchasedFailed.title), message: Text(L10n.Alerts.PurchaseError.message), dismiss: .default(Text(L10n.General.dismissButton)))
}
