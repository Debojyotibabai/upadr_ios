import SwiftUI

struct AuthChecking: View {
    @StateObject var authVieModel: AuthViewModel = AuthViewModel()
    @StateObject var appVieModel: AppViewModel = AppViewModel()
    
    @StateObject var lastSignedupUser: LastSignedupUser = LastSignedupUser()
    
    var body: some View {
        if(authVieModel.isLoggedIn) {
            AppMainStack()
                .environmentObject(authVieModel)
                .environmentObject(appVieModel)
        } else {
            WelcomeScreen()
                .environmentObject(authVieModel)
                .environmentObject(lastSignedupUser)
        }
    }
}

#Preview {
    AuthChecking()
}
