import Foundation

enum DError: String, Error {
    case invalidUsername = "This is not an valid username"
    case unableToComplete = "Request could not be completed"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "Data received is not valid"
    case unableToFavorite = "User could not be favored"
    case alreadyInFavorites = "User is already favored"
}

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    private static let defaults = UserDefaults.standard

    enum Keys { static let favorites = "favorites" }

    static func updateWith(favoriteId: String, actionType: PersistanceActionType, completed: @escaping (Result<[String], Error>) -> Void) {
        retrieveFavoriteIds { result in
            switch result {
            case .success(var oldFavorites):
                switch actionType {
                case .add:
                    guard !oldFavorites.contains(favoriteId) else {
                        completed(.failure(DError.alreadyInFavorites))
                        return
                    }
                    oldFavorites.append(favoriteId)
                    _ = save(favoriteIds: oldFavorites)
                    completed(.success(oldFavorites))
                case .remove:
                    oldFavorites.removeAll { loc in
                        loc == favoriteId
                    }
                    _ = save(favoriteIds: oldFavorites)
                    completed(.success(oldFavorites))
                }

            case .failure:
                completed(.failure(DError.alreadyInFavorites))
            }
        }
    }

    static func isFavorite(_ loc: DLocation) -> Bool {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else { return false }
        do {
            let favorites = try JSONDecoder().decode([String].self, from: favoritesData)
            return favorites.contains(loc.name.en)
        } catch {
            return false
        }
    }

    static func retrieveFavoriteIds(completed: @escaping (Result<[String], Error>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let favorites = try JSONDecoder().decode([String].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(DError.unableToFavorite))
        }
    }

    static func save(favoriteIds: [String]) -> DError? {
        do {
            let encodedFavs = try JSONEncoder().encode(favoriteIds)
            defaults.set(encodedFavs, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
