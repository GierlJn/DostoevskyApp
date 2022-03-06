//
//  DMapViewModel.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 06.03.22.
//

import SwiftUI

class DMapViewModel: ObservableObject{
  //@Published var selectedLocation: DLocation?
  @Published var filter: FilterOptions = .all
}
