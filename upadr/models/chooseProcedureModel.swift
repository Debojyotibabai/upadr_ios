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
