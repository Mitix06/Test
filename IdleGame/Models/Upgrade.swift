import Foundation

struct Upgrade {
    let baseCost: Double
    let costMultiplier: Double
    let cpsPerLevel: Double

    func cost(for level: Int) -> Double {
        baseCost * pow(costMultiplier, Double(level))
    }
}
