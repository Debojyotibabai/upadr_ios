import SwiftUI

struct AppMainStack: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var logoutViewModel: LogoutViewModel
    
    @AppStorage("token") var token: String?
    
    func logout() async {
        await logoutViewModel.logout()
        
        appViewModel.isLogoutModalVisible = false
        
        if(logoutViewModel.isSuccessWhileLoggingOut) {
            token = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                authViewModel.resetAuthViewModel()
                appViewModel.resetAppViewModel()
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
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
                
                if(appViewModel.isLogoutModalVisible) {
                    LogoutModal(
                        parentGeoWidth: geometry.size.width,
                        onLogout: {
                            Task {
                                await logout()
                            }
                        },
                        isLoggingout: logoutViewModel.isLoggingOut
                    )
                }
            }
        }
        .alert(logoutViewModel.logoutErrorResponseData?.message ?? "Something went wrong",
               isPresented: $logoutViewModel.isErrorWhileLoggingOut) {
            Button {
                appViewModel.isLogoutModalVisible = true
            } label: {
                Text("Try again")
            }
            
        }
    }
}

#Preview {
    AppMainStack()
        .environmentObject(AuthViewModel())
        .environmentObject(AppViewModel())
        .environmentObject(LogoutViewModel())
}
