import SwiftUI

class LastSignedupUser: ObservableObject {
    @Published var lastSignedupUserFormData: SignupWithEmailAndPasswordModel?
}
