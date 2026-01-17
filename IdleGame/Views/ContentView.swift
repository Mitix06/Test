import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    @Environment(\.scenePhase) private var scenePhase

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

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
