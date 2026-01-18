import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: GameViewModel
    @Environment(\.scenePhase) private var scenePhase

    init(viewModel: GameViewModel = GameViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        TabView {
            mainView
                .tabItem {
                    Label("Game", systemImage: "bitcoinsign.circle")
                }

            StatsView(viewModel: viewModel)
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }

            PrestigeView(viewModel: viewModel)
                .tabItem {
                    Label("Prestige", systemImage: "sparkles")
                }
        }
        .onChange(of: scenePhase) { _, newPhase in
            viewModel.handleScenePhaseChange(newPhase)
        }
    }

    private var mainView: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Coins")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    Text(viewModel.formattedCoins)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                }

                VStack(spacing: 4) {
                    Text("Production")
                        .font(.headline)
                    Text("\(viewModel.formattedCps) / sec")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                Button {
                    viewModel.buyUpgrade()
                } label: {
                    VStack(spacing: 6) {
                        Text("Upgrade +1 cps")
                            .font(.headline)
                        Text("Cost: \(viewModel.formattedUpgradeCost) coins")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .disabled(viewModel.coins < viewModel.upgradeCost)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Buildings")
                        .font(.title3.bold())
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.buildings) { building in
                            let cost = viewModel.buildingCost(for: building)
                            BuildingCardView(
                                building: building,
                                costText: viewModel.format(value: cost),
                                canUpgrade: viewModel.coins >= cost && !viewModel.isBuildingMaxed(building)
                            ) {
                                viewModel.upgradeBuilding(building)
                            }
                        }
                    }
                }

                Spacer(minLength: 24)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(viewModel: GameViewModel.preview())
}
