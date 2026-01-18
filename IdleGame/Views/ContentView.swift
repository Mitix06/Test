import SwiftUI

struct ContentView: View {
    @StateObject private var vm = GameViewModel()

    var body: some View {
        CityView(vm: vm)
    }
}

#Preview {
    ContentView()
}
