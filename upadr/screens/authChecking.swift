import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appVieModel: AppViewModel = AppViewModel()
    
    @StateObject var signupViewModel: SignupViewModel = SignupViewModel()
    
    var body: some View {
        if(authVieModel.isLoggedIn) {
            AppMainStack()
                .environmentObject(authVieModel)
                .environmentObject(appVieModel)
        } else {
            WelcomeScreen()
                .environmentObject(authVieModel)
                .environmentObject(signupViewModel)
        }
    }
}

#Preview {
    AuthChecking(authVieModel: AuthViewModel(), appVieModel: AppViewModel())
}
