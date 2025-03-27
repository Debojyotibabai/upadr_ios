import Foundation

// MARK: - LoginWithEmailAndPasswordModel
struct LoginWithEmailAndPasswordModel: Codable {
    var emailAddress: String
    var password: String
    var userType: String = "Consumer"
}

// MARK: - LoginWithEmailAndPasswordError
struct LoginWithEmailAndPasswordError: Codable {
    var message: String
}

// MARK: - LoginWithEmailAndPasswordResponse
struct LoginWithEmailAndPasswordResponse: Codable {
    let message: String
    let tokens: Tokens
    let user: User
}

// MARK: - Tokens
struct Tokens: Codable {
    let accessToken, idToken, refreshToken, secretHash: String
}

// MARK: - User
struct User: Codable {
    let userID, userType: String
    let profilePictureURL: JSONNull?
    let firstName, lastName: String
    let profileImage, profileImageURL: JSONNull?
    let emailAddress: String
    let phoneCountryCode, phoneNumber: JSONNull?
    let userSettings: UserSettings
    let accountStatus, registeredOn: String
    let numberOfUnreadNotifications, numberOfUnreadSurveys: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userType
        case profilePictureURL = "profilePictureUrl"
        case firstName, lastName, profileImage
        case profileImageURL = "profile_image_url"
        case emailAddress, phoneCountryCode, phoneNumber, userSettings, accountStatus, registeredOn, numberOfUnreadNotifications, numberOfUnreadSurveys
    }
}

// MARK: - UserSettings
struct UserSettings: Codable {
    let isAvailable, needToChangePassword: Bool
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        // Since all JSONNull instances are considered equal, we can use a constant hash value
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
