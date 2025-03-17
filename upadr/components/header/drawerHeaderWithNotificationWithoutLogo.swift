import SwiftUI

struct DrawerHeaderWithNotificationWithoutLogo: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .fontWeight(.medium)
                .foregroundStyle(.deepBlue)
                .onTapGesture {
                    appViewModel.openSidebarDrawer()
                }
            
            Spacer()
            
            Image(systemName: "bell.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .fontWeight(.medium)
                .foregroundStyle(.deepBlue)
                .onTapGesture {
                    appViewModel.selectedPreviousAppStack = appViewModel.selectedAppStack
                    appViewModel.selectedAppStack = .notificationStack
                }
        }
        .padding()
        .background(.lightSky)
    }
}


#Preview {
    DrawerHeaderWithNotificationWithoutLogo()
        .environmentObject(AppViewModel())
}
