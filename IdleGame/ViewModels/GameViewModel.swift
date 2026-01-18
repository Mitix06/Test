import Foundation
import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {
    @Published var gold: Int = 500
    @Published var buildings: [Building] = [
        Building(type: .townHall),
        Building(type: .barracks),
        Building(type: .mageGuild),
        Building(type: .marketplace)
    ]

    @Published var selectedBuildingID: UUID? = nil

    var selectedBuilding: Building? {
        guard let id = selectedBuildingID else { return nil }
        return buildings.first(where: { $0.id == id })
    }

    func select(_ building: Building) {
        selectedBuildingID = building.id
    }

    func upgradeSelected() {
        guard let id = selectedBuildingID,
              let index = buildings.firstIndex(where: { $0.id == id }) else { return }

        let building = buildings[index]
        if building.isMaxed { return }

        let cost = building.upgradeCost()
        guard gold >= cost else { return }

        gold -= cost
        buildings[index].level += 1
    }
}
