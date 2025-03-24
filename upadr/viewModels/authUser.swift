import SwiftUI

class AuthUser: ObservableObject {
    @Published var lastSignedupUserFormData: SignupWithEmailAndPasswordModel?
    @Published var forgotPasswordEmailAddress: String?
}
