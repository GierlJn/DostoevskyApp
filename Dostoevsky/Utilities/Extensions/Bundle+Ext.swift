import Foundation

extension Bundle {
    func decode<T: Decodable>(_: T.Type, from file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) in bundle")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) in bundle")
        }
        return loaded
    }
}
