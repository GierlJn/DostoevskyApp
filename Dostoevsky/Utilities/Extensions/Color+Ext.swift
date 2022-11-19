//
//  Color+Ext.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 25.02.22.
//

import SwiftUI

extension Color {
    static let brandCategory1 = Color("category1")
    static let brandCategory2 = Color("category2")
    static let brandCategory3 = Color("category3")
    static let brandPrimary = Color("brandPrimary")
    static let tabColor = Color("tabColor")
    static let backgroundStart = Color("backgroundStart")
    static let backgroundEnd = Color("backgroundEnd")
    static let customAccentColor = Color("accentColor")
    static let accentLight = Color("accentColorLight")
    static let detailActionBarBackground = Color(hex: "#1C1C1EFF")
}

extension UIColor {
    static let brandCategory1 = UIColor(named: "category1")
    static let brandCategory2 = UIColor(named: "category2")
    static let brandCategory3 = UIColor(named: "category3")
    static let brandPrimary = UIColor(named: "brandPrimary")
    static let tabColor = UIColor(named: "tabColor")
    static let customAccentColor = UIColor(named: "accentColor")
    static let accentLight = UIColor(named: "accentColorLight")
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var red: Double = 0.0
        var green: Double = 0.0
        var blue: Double = 0.0
        var opacity: Double = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            red = Double((rgb & 0xFF0000) >> 16) / 255.0
            green = Double((rgb & 0x00FF00) >> 8) / 255.0
            blue = Double(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            red = Double((rgb & 0xFF000000) >> 24) / 255.0
            green = Double((rgb & 0x00FF0000) >> 16) / 255.0
            blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
            opacity = Double(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
