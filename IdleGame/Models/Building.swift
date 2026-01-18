import Foundation

enum BuildingType: String, Codable, CaseIterable, Identifiable {
    case townHall
    case barracks
    case mageGuild
    case marketplace

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .townHall: return "Hôtel de Ville"
        case .barracks: return "Caserne"
        case .mageGuild: return "Guilde des Mages"
        case .marketplace: return "Marché"
        }
    }

    /// IMPORTANT: mets des images dans Assets avec ces noms:
    /// townHall_0, townHall_1, townHall_2...
    /// barracks_0, barracks_1...
    func imageName(level: Int) -> String {
        "\(rawValue)_\(level)"
    }

    var maxLevel: Int {
        switch self {
        case .townHall: return 4
        case .barracks: return 3
        case .mageGuild: return 3
        case .marketplace: return 2
        }
    }

    var baseCost: Int {
        switch self {
        case .townHall: return 200
        case .barracks: return 150
        case .mageGuild: return 180
        case .marketplace: return 120
        }
    }

    var costMultiplier: Double { 1.6 }
}

struct Building: Identifiable, Codable, Equatable {
    let id: UUID
    let type: BuildingType
    var level: Int

    init(id: UUID = UUID(), type: BuildingType, level: Int = 0) {
        self.id = id
        self.type = type
        self.level = level
    }

    var isMaxed: Bool { level >= type.maxLevel }

    func upgradeCost() -> Int {
        // coût = base * multiplier^level (donc augmente à chaque upgrade)
        let raw = Double(type.baseCost) * pow(type.costMultiplier, Double(level))
        return max(1, Int(raw.rounded()))
    }
}
