import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appViewModel: AppViewModel = AppViewModel()
    
    @StateObject var authUserViewModel: AuthUserViewModel = AuthUserViewModel()
    @StateObject var procedureViewModel: ProcedureViewModel = ProcedureViewModel()
    
    @AppStorage("token") var token: String?
    
    var body: some View {
        if(token != nil) {
            AppMainStack()
                .environmentObject(authVieModel)
                .environmentObject(appViewModel)
                .environmentObject(procedureViewModel)
        } else {
            WelcomeScreen()
                .environmentObject(authVieModel)
                .environmentObject(authUserViewModel)
        }
    }
}

#Preview {
    AuthChecking()
}
