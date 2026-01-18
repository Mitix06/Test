import SwiftUI

struct CityView: View {
    @ObservedObject var vm: GameViewModel

    var body: some View {
        ZStack {
            background

            buildingButton(type: .townHall, at: CGPoint(x: 190, y: 160), size: CGSize(width: 200, height: 140))
            buildingButton(type: .barracks, at: CGPoint(x: 110, y: 360), size: CGSize(width: 170, height: 120))
            buildingButton(type: .mageGuild, at: CGPoint(x: 290, y: 360), size: CGSize(width: 170, height: 120))
            buildingButton(type: .marketplace, at: CGPoint(x: 190, y: 520), size: CGSize(width: 220, height: 120))

            VStack {
                HStack {
                    Text("💰 Or: \(vm.gold)")
                        .font(.headline)
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .overlay(alignment: .bottom) {
            if let building = vm.selectedBuilding {
                BuildingPanel(building: building, gold: vm.gold) {
                    vm.upgradeSelected()
                }
                .padding(.bottom, 14)
                .padding(.horizontal, 12)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.snappy, value: vm.selectedBuildingID)
    }

    @ViewBuilder
    private var background: some View {
        if UIImage(named: "city_bg") != nil {
            Image("city_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        } else {
            LinearGradient(colors: [.blue.opacity(0.25), .green.opacity(0.25)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }

    private func buildingButton(type: BuildingType, at point: CGPoint, size: CGSize) -> some View {
        let building = vm.buildings.first(where: { $0.type == type })!

        return Button {
            vm.select(building)
        } label: {
            BuildingSprite(type: type, level: building.level)
                .frame(width: size.width, height: size.height)
        }
        .position(point)
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

struct BuildingSprite: View {
    let type: BuildingType
    let level: Int

    var body: some View {
        let name = type.imageName(level: level)

        ZStack(alignment: .bottomLeading) {
            if UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 6)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        VStack(spacing: 6) {
                            Text(type.displayName)
                                .font(.headline)
                            Text("Niv. \(level)")
                                .font(.subheadline)
                        }
                        .padding()
                    )
            }

            Text("Niv. \(level)")
                .font(.caption.bold())
                .padding(8)
                .background(.black.opacity(0.35))
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(8)
        }
    }
}
