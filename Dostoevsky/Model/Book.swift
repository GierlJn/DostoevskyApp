//
//  Book.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 14.03.22.
//

import SwiftUI

struct Book: Codable, Hashable {
  let en, ru: String

  var localizedName: String {
    isRussian() ? ru : en
  }

  var image: Image {
    return Image(en)
  }
}
