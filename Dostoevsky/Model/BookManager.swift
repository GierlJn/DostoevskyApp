import Foundation

class BookManager {
    static let books = Bundle.main.decode([Book].self, from: "books.json")
}
