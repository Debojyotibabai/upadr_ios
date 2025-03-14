import SwiftUI

struct NotificationStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack(path: $appViewModel.notificationStackNavigationPath) {
            NotificationScreen()
        }
    }
}

#Preview {
    NotificationStack()
        .environmentObject(AppViewModel())
}
