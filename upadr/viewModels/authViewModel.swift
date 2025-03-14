import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @Published var authNavigationPath: NavigationPath = NavigationPath()
}

enum AuthScreens {
    case login, signup, verifyAccount, forgotPassword, createNewPassword
}
