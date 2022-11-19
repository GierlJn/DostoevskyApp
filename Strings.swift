// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum About {
    /// Premium
    internal static let buyPremium = L10n.tr("Localizable", "about.buyPremium", fallback: "Premium")
    internal enum Email {
      /// E-mail us
      internal static let action = L10n.tr("Localizable", "about.email.action", fallback: "E-mail us")
      /// We missed something?
      internal static let sectionheader = L10n.tr("Localizable", "about.email.sectionheader", fallback: "We missed something?")
    }
    internal enum Useractions {
      /// Spread the word
      internal static let sectionheader = L10n.tr("Localizable", "about.useractions.sectionheader", fallback: "Spread the word")
      internal enum Action {
        /// Rate App
        internal static let rate = L10n.tr("Localizable", "about.useractions.action.rate", fallback: "Rate App")
        /// Share App
        internal static let share = L10n.tr("Localizable", "about.useractions.action.share", fallback: "Share App")
      }
      internal enum Sharesheet {
        /// Check out this cool app!
        internal static let text = L10n.tr("Localizable", "about.useractions.sharesheet.text", fallback: "Check out this cool app!")
      }
    }
  }
  internal enum Alerts {
    internal enum FailedVerification {
      /// The transaction was not succesful.
      /// Your purchase could not be verified by the App Store.
      internal static let message = L10n.tr("Localizable", "alerts.failedVerification.message", fallback: "The transaction was not succesful.\nYour purchase could not be verified by the App Store.")
    }
    internal enum LocationDenied {
      /// The app has no permission to access your location. 
      /// You can change that in your phones settings.
      internal static let message = L10n.tr("Localizable", "alerts.locationDenied.message", fallback: "The app has no permission to access your location. \nYou can change that in your phones settings.")
      /// Locations Denied
      internal static let title = L10n.tr("Localizable", "alerts.locationDenied.title", fallback: "Locations Denied")
    }
    internal enum LocationDisabled {
      /// Your phones location services are disabled. 
      /// You can change that in your phones settings.
      internal static let message = L10n.tr("Localizable", "alerts.locationDisabled.message", fallback: "Your phones location services are disabled. \nYou can change that in your phones settings.")
      /// Locations Disabled
      internal static let title = L10n.tr("Localizable", "alerts.locationDisabled.title", fallback: "Locations Disabled")
    }
    internal enum LocationRestricted {
      /// Your location is restricted.
      internal static let message = L10n.tr("Localizable", "alerts.locationRestricted.message", fallback: "Your location is restricted.")
      /// Locations Restricted
      internal static let title = L10n.tr("Localizable", "alerts.locationRestricted.title", fallback: "Locations Restricted")
    }
    internal enum Pending {
      /// The purchase is pending, and requires additional action.
      internal static let message = L10n.tr("Localizable", "alerts.pending.message", fallback: "The purchase is pending, and requires additional action.")
    }
    internal enum PremiumPurchased {
      /// Enjoy using all features.
      internal static let message = L10n.tr("Localizable", "alerts.premiumPurchased.message", fallback: "Enjoy using all features.")
      /// Purchase succesful!
      internal static let title = L10n.tr("Localizable", "alerts.premiumPurchased.title", fallback: "Purchase succesful!")
    }
    internal enum PurchaseError {
      /// The purchase was not successful.
      /// Please try again.
      internal static let message = L10n.tr("Localizable", "alerts.purchaseError.message", fallback: "The purchase was not successful.\nPlease try again.")
    }
    internal enum PurchasedFailed {
      /// Purchase failed
      internal static let title = L10n.tr("Localizable", "alerts.purchasedFailed.title", fallback: "Purchase failed")
    }
    internal enum UnableToGetLocations {
      /// Unable to retrieve locations at this time. 
      ///  Please try again.
      internal static let message = L10n.tr("Localizable", "alerts.unableToGetLocations.message", fallback: "Unable to retrieve locations at this time. \n Please try again.")
      /// Locations Error
      internal static let title = L10n.tr("Localizable", "alerts.unableToGetLocations.title", fallback: "Locations Error")
    }
  }
  internal enum Book {
    internal enum Title {
      /// Crime and Punishment
      internal static let crimeandpunishment = L10n.tr("Localizable", "book.title.crimeandpunishment", fallback: "Crime and Punishment")
      /// Humiliated and Insulted
      internal static let humiliatedandinsulted = L10n.tr("Localizable", "book.title.humiliatedandinsulted", fallback: "Humiliated and Insulted")
      /// Books (Premium)
      internal static let noPremium = L10n.tr("Localizable", "book.title.noPremium", fallback: "Books (Premium)")
      /// Books
      internal static let premiumActive = L10n.tr("Localizable", "book.title.premiumActive", fallback: "Books")
    }
  }
  internal enum BuyPremium {
    /// Unlocks all the places from Dostoevskys Crime and Punishment.
    internal static let feature1 = L10n.tr("Localizable", "buyPremium.feature1", fallback: "Unlocks all the places from Dostoevskys Crime and Punishment.")
    /// Unlocks all the places from Dostoevskys Humiliated and Insulted.
    internal static let feature2 = L10n.tr("Localizable", "buyPremium.feature2", fallback: "Unlocks all the places from Dostoevskys Humiliated and Insulted.")
    /// Lets you navigate to a place with one click.
    internal static let feature3 = L10n.tr("Localizable", "buyPremium.feature3", fallback: "Lets you navigate to a place with one click.")
    /// Unlock all features for %@/%s.
    internal static func priceOffer(_ p1: Any, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "buyPremium.priceOffer", String(describing: p1), p2, fallback: "Unlock all features for %@/%s.")
    }
    /// Premium upgrade
    internal static let title = L10n.tr("Localizable", "buyPremium.title", fallback: "Premium upgrade")
    /// Unlock all features for: 
    internal static let unlockAllFeatures = L10n.tr("Localizable", "buyPremium.unlockAllFeatures", fallback: "Unlock all features for: ")
    internal enum Action {
      /// Already bought? Restore your purchase
      internal static let restore = L10n.tr("Localizable", "buyPremium.action.restore", fallback: "Already bought? Restore your purchase")
      /// Upgrade now
      internal static let upgrade = L10n.tr("Localizable", "buyPremium.action.upgrade", fallback: "Upgrade now")
    }
  }
  internal enum Compactlist {
    internal enum Action {
      /// Sort
      internal static let sort = L10n.tr("Localizable", "compactlist.action.sort", fallback: "Sort")
    }
    internal enum Sort {
      internal enum Option {
        /// Date
        internal static let date = L10n.tr("Localizable", "compactlist.sort.option.date", fallback: "Date")
        /// Favorites
        internal static let favorites = L10n.tr("Localizable", "compactlist.sort.option.favorites", fallback: "Favorites")
        /// Rating
        internal static let rating = L10n.tr("Localizable", "compactlist.sort.option.rating", fallback: "Rating")
      }
    }
  }
  internal enum General {
    /// Ok
    internal static let dismissButton = L10n.tr("Localizable", "general.dismissButton", fallback: "Ok")
  }
  internal enum Map {
    internal enum Filter {
      internal enum Option {
        /// After exile
        internal static let afterexile = L10n.tr("Localizable", "map.filter.option.afterexile", fallback: "After exile")
        /// Before exile
        internal static let beforeexile = L10n.tr("Localizable", "map.filter.option.beforeexile", fallback: "Before exile")
        /// Favorites
        internal static let favorites = L10n.tr("Localizable", "map.filter.option.favorites", fallback: "Favorites")
      }
    }
  }
  internal enum Onboard {
    /// Explore
    internal static let action = L10n.tr("Localizable", "onboard.action", fallback: "Explore")
    /// Dostoevsky's Petersburg
    internal static let header = L10n.tr("Localizable", "onboard.header", fallback: "Dostoevsky's Petersburg")
  }
  internal enum Tabbar {
    internal enum Label {
      /// About
      internal static let about = L10n.tr("Localizable", "tabbar.label.about", fallback: "About")
      /// Biography
      internal static let biography = L10n.tr("Localizable", "tabbar.label.biography", fallback: "Biography")
      /// Books
      internal static let books = L10n.tr("Localizable", "tabbar.label.books", fallback: "Books")
      /// Map
      internal static let map = L10n.tr("Localizable", "tabbar.label.map", fallback: "Map")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
