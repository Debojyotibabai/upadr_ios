import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appViewModel: AppViewModel = AppViewModel()
    
    @StateObject var authUserViewModel: AuthUserViewModel = AuthUserViewModel()
    
    @AppStorage("token") var token: String?
    
    var body: some View {
        if(token != nil) {
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
