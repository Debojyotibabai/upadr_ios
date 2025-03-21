struct VerifyEmailModel: Codable {
    var ConfirmationCode: String
    var emailAddress: String
    var password: String
    var userType: String = "Consumer"
}

struct VerifyEmailResponseModel: Codable {
    var message: String
}
