import SwiftUI

struct BuildingPanel: View {
    let building: Building
    let gold: Int
    let onUpgrade: () -> Void

    var body: some View {
        let cost = building.upgradeCost()
        let canUpgrade = !building.isMaxed && gold >= cost

        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(building.type.displayName)
                        .font(.title3.bold())
                    Text("Niveau \(building.level) / \(building.type.maxLevel)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            HStack(spacing: 10) {
                if building.isMaxed {
                    Text("✅ Niveau max atteint")
                        .font(.subheadline.bold())
                        .foregroundStyle(.green)
                    Spacer()
                } else {
                    Text("Coût: \(cost) or")
                        .font(.subheadline.bold())
                    Spacer()

                    Button {
                        onUpgrade()
                    } label: {
                        Text("Améliorer")
                            .frame(minWidth: 120)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!canUpgrade)
                }
            }
        }
        .padding(14)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 10)
    }
}
