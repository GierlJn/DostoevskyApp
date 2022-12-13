import SwiftUI

struct Book: Codable, Hashable {
    let en, ru: String

    var localizedName: String {
        isRussianLanguage() ? ru : en
    }

    var image: Image {
        Image(en)
    }
}
