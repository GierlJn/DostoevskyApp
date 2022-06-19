//
//  Double+Ext.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 04.03.22.
//

import Foundation

extension Double {
    static func initFromCommaString(str: String) -> Double {
        Double(str.split(separator: ",").joined(separator: ".")) ?? 0
    }
}
