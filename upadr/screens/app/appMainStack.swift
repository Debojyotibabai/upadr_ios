import SwiftUI

struct AppMainStack: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        ZStack {
            switch appViewModel.selectedAppStack {
            case .chooseProcedureStack:
                ChooseProcedureStack()
            case .procedureStack:
                ProcedureStack()
            case .tipStack:
                TipStack()
            case .surveyStack:
                SurveyStack()
            case .settingsStack:
                SettingsStack()
            case .notificationStack:
                NotificationStack()
            }
            
            if(appViewModel.isSidebarDrawerOpened) {
                SidebarDrawer()
            }
        }
    }
}


#Preview {
    AppMainStack()
        .environmentObject(AuthViewModel())
        .environmentObject(AppViewModel())
}
