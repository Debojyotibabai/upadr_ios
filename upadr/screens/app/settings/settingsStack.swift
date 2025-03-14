import SwiftUI

struct SettingsStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack(path: $appViewModel.settingsStackNavigationPath) {
            SettingsScreen()
        }
    }
}

#Preview {
    SettingsStack()
        .environmentObject(AppViewModel())
}
