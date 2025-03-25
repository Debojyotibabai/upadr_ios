import SwiftUI

class AuthUserViewModel: ObservableObject {
    @Published var lastSignedupUserFormData: SignupWithEmailAndPasswordModel?
    @Published var lastForgotPasswordFormData: ForgotPasswordModel?
}
