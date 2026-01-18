import SwiftUI

struct StatsView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Production") {
                    statRow(title: "Coins per second", value: viewModel.formattedCps)
                    statRow(title: "Upgrade level", value: "\(viewModel.upgradeLevel)")
                }

                Section("Progress") {
                    statRow(title: "Total coins earned", value: format(value: viewModel.state.totalCoinsEarned))
                    statRow(title: "Total prestiges", value: "\(viewModel.state.totalPrestiges)")
                    statRow(title: "Gems", value: "\(viewModel.gems)")
                }

                Section("Buildings") {
                    ForEach(viewModel.buildings) { building in
                        statRow(
                            title: building.type.displayName,
                            value: "Niveau \(building.level) / \(building.type.maxLevel)"
                        )
                    }
                }
            }
            .navigationTitle("Stats")
        }
    }

    private func statRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }

    private func format(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
}

#Preview {
    StatsView(viewModel: GameViewModel.preview())
}
