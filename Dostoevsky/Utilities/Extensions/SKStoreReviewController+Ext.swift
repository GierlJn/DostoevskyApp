//
//  SKStoreReviewController+Ext.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 14.03.22.
//

import StoreKit

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive
        }) as? UIWindowScene {
            requestReview(in: scene)
        }
    }
}
