import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var authNavigationPath: NavigationPath = NavigationPath()
    
    func resetAuthViewModel() {
        authNavigationPath = NavigationPath()
    }
}

enum AuthScreens {
    case login, signup, verifyAccount, forgotPassword, createNewPassword
}
