import SwiftUI

struct BuildingCardView: View {
    let building: Building
    let costText: String
    let canUpgrade: Bool
    let onUpgrade: () -> Void

    var body: some View {
        Button {
            onUpgrade()
        } label: {
            VStack(spacing: 8) {
                Image(building.type.imageName(level: building.level))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(building.type.displayName)
                    .font(.headline)
                Text("Niveau \(building.level) / \(building.type.maxLevel)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(building.isMaxed ? "Max niveau" : "Améliorer : \(costText) pièces")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .disabled(!canUpgrade)
    }
}

#Preview {
    BuildingCardView(
        building: Building(type: .townHall, level: 2),
        costText: "320",
        canUpgrade: true,
        onUpgrade: {}
    )
    .padding()
}
