import Foundation
import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var state: GameState

    private let upgrade = Upgrade(baseCost: 10, costMultiplier: 1.15, cpsPerLevel: 1)
    private let persistence: PersistenceService
    private var timer: Timer?

    private let maxOfflineHours: TimeInterval = 8 * 60 * 60
    private let gemMultiplier: Double = 0.1

    init(persistence: PersistenceService = .shared) {
        self.persistence = persistence
        self.state = persistence.load()
        applyOfflineEarnings()
        startTimer()
    }

    var coins: Double { state.coins }
    var gems: Int { state.gems }
    var upgradeLevel: Int { state.upgradeLevel }
    var upgradeCost: Double { upgrade.cost(for: state.upgradeLevel) }

    var coinsPerSecond: Double {
        let baseCps = 1 + (upgrade.cpsPerLevel * Double(state.upgradeLevel))
        let prestigeBoost = 1 + (Double(state.gems) * gemMultiplier)
        return baseCps * prestigeBoost
    }

    var formattedCoins: String { format(value: state.coins) }
    var formattedCps: String { format(value: coinsPerSecond) }
    var formattedUpgradeCost: String { format(value: upgradeCost) }

    func buyUpgrade() {
        let cost = upgradeCost
        guard state.coins >= cost else { return }
        state.coins -= cost
        state.upgradeLevel += 1
        persistence.save(state: state)
    }

    func prestige() {
        let gemsEarned = max(1, Int(state.totalCoinsEarned / 1_000))
        state.gems += gemsEarned
        state.totalPrestiges += 1
        state.coins = 0
        state.upgradeLevel = 0
        state.lastActiveDate = Date()
        persistence.save(state: state)
    }

    func handleScenePhaseChange(_ phase: ScenePhase) {
        switch phase {
        case .active:
            applyOfflineEarnings()
            startTimer()
        case .inactive, .background:
            stopTimer()
            state.lastActiveDate = Date()
            persistence.save(state: state)
        @unknown default:
            break
        }
    }

    func resetProgress() {
        state = GameState.initial()
        persistence.save(state: state)
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func tick() {
        state.coins += coinsPerSecond
        state.totalCoinsEarned += coinsPerSecond
        persistence.save(state: state)
    }

    private func applyOfflineEarnings() {
        let now = Date()
        let elapsed = min(now.timeIntervalSince(state.lastActiveDate), maxOfflineHours)
        guard elapsed > 0 else { return }
        let earned = coinsPerSecond * elapsed
        state.coins += earned
        state.totalCoinsEarned += earned
        state.lastActiveDate = now
        persistence.save(state: state)
    }

    private func format(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
}
