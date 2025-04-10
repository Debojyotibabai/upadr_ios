import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appViewModel: AppViewModel = AppViewModel()
    
    @StateObject var authUserViewModel: AuthUserViewModel = AuthUserViewModel()
    
    @StateObject var forgotPasswordViewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    @StateObject var createNewPasswordViewModel: CreateNewPasswordViewModel = CreateNewPasswordViewModel()
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    @StateObject var signupViewModel: SignupViewModel = SignupViewModel()
    @StateObject var verifyEmailViewModel: VerifyEmailViewModel = VerifyEmailViewModel()
    
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
                .environmentObject(forgotPasswordViewModel)
                .environmentObject(createNewPasswordViewModel)
                .environmentObject(loginViewModel)
                .environmentObject(signupViewModel)
                .environmentObject(verifyEmailViewModel)
        }
    }
}

#Preview {
    AuthChecking()
}
