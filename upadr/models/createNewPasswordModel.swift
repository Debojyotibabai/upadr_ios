import SwiftUI

struct CreateNewPasswordModel: Codable {
    var confirmPassword: String
    var emailAddress: String
    var newPassword: String
    var resetCode: String
    var userType: String = "Consumer"
}

struct CreateNewPasswordResponseModel: Codable {
    var message: String
}
