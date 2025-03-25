import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appViewModel: AppViewModel = AppViewModel()
    
    @StateObject var authUserViewModel: AuthUserViewModel = AuthUserViewModel()
    
    var body: some View {
        if(authVieModel.isLoggedIn) {
            AppMainStack()
                .environmentObject(authVieModel)
                .environmentObject(appViewModel)
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
