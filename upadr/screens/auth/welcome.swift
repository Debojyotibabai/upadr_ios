import SwiftUI

struct WelcomeScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack(path: $authViewModel.authNavigationPath) {
            GeometryReader { geo in
                VStack {
                    Image(.logoWithName)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                    
                    Spacer().frame(height: 100)
                    
                    SolidButton(text: "Sign Up", width: geo.size.width * 0.8, onPress: {
                        authViewModel.authNavigationPath.append(AuthScreens.signup)
                    })
                    
                    Spacer().frame(height: 15)
                    
                    SolidButton(text: "Login", width: geo.size.width * 0.8, onPress: {
                        authViewModel.authNavigationPath.append(AuthScreens.login)
                    })
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height)
                .background(.lightSky)
            }
            
            .navigationDestination(for: AuthScreens.self) { screen in
                switch screen {
                case .login:
                    LoginScreen()
                case .signup:
                    SignupScreen()
                case .verifyAccount:
                    VerifyAccountScreen()
                        .navigationBarBackButtonHidden()
                case .forgotPassword:
                    ForgotPasswordScreen()
                        .navigationBarBackButtonHidden()
                case .createNewPassword:
                    CreateNewPasswordScreen()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

#Preview {
    WelcomeScreen()
        .environmentObject(AuthViewModel())
}
