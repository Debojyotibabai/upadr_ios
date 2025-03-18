struct SignupWithEmailAndPasswordModel: Codable {
    var confirmPassword: String
    var emailAddress: String
    var firstName: String
    var lastName: String
    var password: String
    var userType: String = "Consumer"
}

struct SignupWithEmailAndPasswordResponseModel: Codable {
    var message: String
}
