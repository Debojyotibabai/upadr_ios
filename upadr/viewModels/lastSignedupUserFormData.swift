import SwiftUI

class LastSignedupUserFormData: ObservableObject {
    @Published var lastSignedupUser: SignupWithEmailAndPasswordModel?
}
