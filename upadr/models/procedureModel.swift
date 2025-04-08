import Foundation

// MARK: - CreateProcedureRequestModel
struct CreateProcedureRequestModel: Codable {
    var dateTime: String
    var procedureId: String
    var procedureSetId: String? = nil
    var surveyId: String? = nil
}

// MARK: - CreateProcedureErrorModel
struct CreateProcedureErrorModel: Codable {
    var message: String
}

// MARK: - CreateProcedureResponseModel
struct CreateProcedureResponseModel: Codable {
    let message: String?
    let userProcedure: UserProcedure?
}

// MARK: - AllProcedureResponseModel
struct AllProcedureResponseModel: Codable {
    let upcomingUserProcedures, completedUserProcedures: [UserProcedure]?
}

// MARK: - UserProcedure
struct UserProcedure: Codable, Identifiable {
    let userProcedureID: String?
    let procedure: Procedure?
    let procedureSet: ProcedureSet?
    let dateTime: String?
    
    var id: String? {
        return userProcedureID
    }
    
    enum CodingKeys: String, CodingKey {
        case userProcedureID = "userProcedureId"
        case procedure, procedureSet, dateTime
    }
}

// MARK: - Procedure
struct Procedure: Codable, Identifiable {
    let procedureID, title, status, createdAt: String?
    let updatedAt: JSONNull?
    let numberOfDefaultSteps, numberOfTotalSteps, numberOfSets: Int?
    let steps: [Step]?
    
    var id: String? {
        return procedureID
    }
    
    enum CodingKeys: String, CodingKey {
        case procedureID = "procedureId"
        case title, status, createdAt, updatedAt, numberOfDefaultSteps, numberOfTotalSteps, numberOfSets, steps
    }
}

// MARK: - Step
struct Step: Codable {
    let procedureStepID: String?
    let procedureSet: ProcedureSet?
    let procedureStepImageURL: String?
    let when: String?
    let isBeforeProcedure: Bool?
    let description, createdAt, updatedAt, notificationTriggerTime: String?
    let contentViewedAt: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case procedureStepID = "procedureStepId"
        case procedureSet
        case procedureStepImageURL = "procedureStepImageUrl"
        case when, isBeforeProcedure, description, createdAt, updatedAt, notificationTriggerTime, contentViewedAt
    }
}

// MARK: - ProcedureSet
struct ProcedureSet: Codable {
    let procedureSetID: String?
    let setName: String?
    
    enum CodingKeys: String, CodingKey {
        case procedureSetID = "procedureSetId"
        case setName
    }
}
