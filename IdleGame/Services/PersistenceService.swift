import Foundation

final class PersistenceService {
    static let shared = PersistenceService()

    private let saveKey = "idleGameState"

    private init() {}

    func save(state: GameState) {
        do {
            let data = try JSONEncoder().encode(state)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Failed to save state: \(error)")
        }
    }

    func load() -> GameState {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            return GameState.initial()
        }

        do {
            return try JSONDecoder().decode(GameState.self, from: data)
        } catch {
            print("Failed to load state: \(error)")
            return GameState.initial()
        }
    }
}
