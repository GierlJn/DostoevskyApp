// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum About {
    internal enum Email {
      /// E-mail us
      internal static let action = L10n.tr("Localizable", "about.email.action")
      /// We missed something?
      internal static let sectionheader = L10n.tr("Localizable", "about.email.sectionheader")
    }
    internal enum Useractions {
      /// Spread the word
      internal static let sectionheader = L10n.tr("Localizable", "about.useractions.sectionheader")
      internal enum Action {
        /// Rate App
        internal static let rate = L10n.tr("Localizable", "about.useractions.action.rate")
        /// Share App
        internal static let share = L10n.tr("Localizable", "about.useractions.action.share")
      }
      internal enum Sharesheet {
        /// Check out this cool app!
        internal static let text = L10n.tr("Localizable", "about.useractions.sharesheet.text")
      }
    }
  }

  internal enum Book {
    internal enum Title {
      /// Crime and Punishment
      internal static let crimeandpunishment = L10n.tr("Localizable", "book.title.crimeandpunishment")
      /// Humiliated and Insulted
      internal static let humiliatedandinsulted = L10n.tr("Localizable", "book.title.humiliatedandinsulted")
    }
  }

  internal enum Compactlist {
    internal enum Action {
      /// Sort
      internal static let sort = L10n.tr("Localizable", "compactlist.action.sort")
    }
    internal enum Sort {
      internal enum Option {
        /// Date
        internal static let date = L10n.tr("Localizable", "compactlist.sort.option.date")
        /// Favorites
        internal static let favorites = L10n.tr("Localizable", "compactlist.sort.option.favorites")
        /// Rating
        internal static let rating = L10n.tr("Localizable", "compactlist.sort.option.rating")
      }
    }
  }

  internal enum Map {
    internal enum Filter {
      internal enum Option {
        /// After exile
        internal static let afterexile = L10n.tr("Localizable", "map.filter.option.afterexile")
        /// Before exile
        internal static let beforeexile = L10n.tr("Localizable", "map.filter.option.beforeexile")
        /// Favorites
        internal static let favorites = L10n.tr("Localizable", "map.filter.option.favorites")
      }
    }
  }

  internal enum Onboard {
    /// Explore
    internal static let action = L10n.tr("Localizable", "onboard.action")
    /// Dostoevsky's Petersburg
    internal static let header = L10n.tr("Localizable", "onboard.header")
  }

  internal enum Tabbar {
    internal enum Label {
      /// About
      internal static let about = L10n.tr("Localizable", "tabbar.label.about")
      /// Biography
      internal static let biography = L10n.tr("Localizable", "tabbar.label.biography")
      /// Books
      internal static let books = L10n.tr("Localizable", "tabbar.label.books")
      /// Map
      internal static let map = L10n.tr("Localizable", "tabbar.label.map")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
