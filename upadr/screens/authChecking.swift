import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appViewModel: AppViewModel = AppViewModel()
    
    @StateObject var authUserViewModel: AuthUserViewModel = AuthUserViewModel()
    
    @StateObject var chooseProcedureViewModel: ChooseProcedureViewModel = ChooseProcedureViewModel()
    @StateObject var procedureViewModel: ProcedureViewModel = ProcedureViewModel()
    @StateObject var tipViewModel: TipViewModel = TipViewModel()
    
    @AppStorage("token") var token: String?
    
    var body: some View {
        if(token != nil) {
            AppMainStack()
                .environmentObject(authVieModel)
                .environmentObject(appViewModel)
                .environmentObject(chooseProcedureViewModel)
                .environmentObject(procedureViewModel)
                .environmentObject(tipViewModel)
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
