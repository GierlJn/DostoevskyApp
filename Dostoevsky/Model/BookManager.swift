//
//  BookManager.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 25.03.22.
//

import Foundation

class BookManager {

  static let books = Bundle.main.decode([Book].self, from: "books.json")

}
