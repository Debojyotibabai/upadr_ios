struct ForgotPasswordModel: Codable {
    var emailAddress: String
    var userType: String = "Consumer"
}

struct ForgotPasswordResponseModel: Codable {
    var message: String
}
