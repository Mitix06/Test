import Foundation

struct GameState: Codable {
    var coins: Double
    var upgradeLevel: Int
    var gems: Int
    var totalCoinsEarned: Double
    var totalPrestiges: Int
    var lastActiveDate: Date

    static func initial() -> GameState {
        GameState(
            coins: 0,
            upgradeLevel: 0,
            gems: 0,
            totalCoinsEarned: 0,
            totalPrestiges: 0,
            lastActiveDate: Date()
        )
    }
}
