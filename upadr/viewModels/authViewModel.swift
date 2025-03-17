import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @Published var authNavigationPath: NavigationPath = NavigationPath()
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
}

enum AuthScreens {
    case login, signup, verifyAccount, forgotPassword, createNewPassword
}
