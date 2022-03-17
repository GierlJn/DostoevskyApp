//
//  GradientButton.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 16.03.22.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(configuration.isPressed ? LinearGradient(gradient: Gradient(colors: [Color.accentLight, Color.accentLight]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.accentLight, Color.customAccentColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

struct StandardGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .background(configuration.isPressed ? LinearGradient(gradient: Gradient(colors: [Color.accentLight, Color.accentLight]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.accentLight, Color.customAccentColor]), startPoint: .leading, endPoint: .trailing))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}
