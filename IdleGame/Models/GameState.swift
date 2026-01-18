import Foundation

struct GameState: Codable {
    var coins: Double
    var upgradeLevel: Int
    var gems: Int
    var totalCoinsEarned: Double
    var totalPrestiges: Int
    var lastActiveDate: Date
    var buildings: [Building]

    static func initial() -> GameState {
        GameState(
            coins: 0,
            upgradeLevel: 0,
            gems: 0,
            totalCoinsEarned: 0,
            totalPrestiges: 0,
            lastActiveDate: Date(),
            buildings: defaultBuildings()
        )
    }

    static func defaultBuildings() -> [Building] {
        BuildingType.allCases.map { Building(type: $0, level: 0) }
    }

    init(
        coins: Double,
        upgradeLevel: Int,
        gems: Int,
        totalCoinsEarned: Double,
        totalPrestiges: Int,
        lastActiveDate: Date,
        buildings: [Building]
    ) {
        self.coins = coins
        self.upgradeLevel = upgradeLevel
        self.gems = gems
        self.totalCoinsEarned = totalCoinsEarned
        self.totalPrestiges = totalPrestiges
        self.lastActiveDate = lastActiveDate
        self.buildings = buildings
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coins = try container.decode(Double.self, forKey: .coins)
        upgradeLevel = try container.decode(Int.self, forKey: .upgradeLevel)
        gems = try container.decode(Int.self, forKey: .gems)
        totalCoinsEarned = try container.decode(Double.self, forKey: .totalCoinsEarned)
        totalPrestiges = try container.decode(Int.self, forKey: .totalPrestiges)
        lastActiveDate = try container.decode(Date.self, forKey: .lastActiveDate)
        buildings = try container.decodeIfPresent([Building].self, forKey: .buildings) ?? GameState.defaultBuildings()
    }
}
