// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chooseProcedureResponse = try? JSONDecoder().decode(ChooseProcedureResponse.self, from: jsonData)

import Foundation

// MARK: - ChooseProcedureResponse
struct ChooseProcedureResponse: Codable {
    let pagination: Pagination?
    let procedures: [Procedure]?
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalItems, perPage, currentPage, lastPage: Int?
}

// MARK: - Procedure
struct Procedure: Codable, Identifiable {
    let procedureID, title, status, createdAt: String?
    let updatedAt: JSONNull?
    let numberOfDefaultSteps, numberOfTotalSteps, numberOfSets: Int?
    
    var id: String? {
        return procedureID
    }
    
    enum CodingKeys: String, CodingKey {
        case procedureID = "procedureId"
        case title, status, createdAt, updatedAt, numberOfDefaultSteps, numberOfTotalSteps, numberOfSets
    }
}
