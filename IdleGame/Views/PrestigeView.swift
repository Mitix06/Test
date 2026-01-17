import SwiftUI

struct PrestigeView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Gems")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    Text("\(viewModel.gems)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                }

                Text("Each gem boosts production by 10%.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Button {
                    viewModel.prestige()
                } label: {
                    VStack(spacing: 6) {
                        Text("Prestige")
                            .font(.headline)
                        Text("Reset coins and upgrades for gems")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding()
            .navigationTitle("Prestige")
        }
    }
}

#Preview {
    PrestigeView(viewModel: GameViewModel())
}
