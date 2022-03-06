//
//  FilterOptions.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 06.03.22.
//

import SwiftUI

enum FilterOptions{
  case all, beforeExile, afterExile, novels
  
  var getFilterColor: Color{
    switch self{
    case .all:
      return Color.brandPrimary
    case .beforeExile:
      return Color.brandCategory1
    case .afterExile:
      return Color.brandCategory2
    case .novels:
      return Color.brandCategory3
    }
  }
}
