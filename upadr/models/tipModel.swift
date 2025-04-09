import Foundation

// MARK: - ParticularProcedureTipsResponseModel
struct ParticularProcedureTipsResponseModel: Codable {
    var procedureTips: [ProcedureTip]
    
    enum CodingKeys: String, CodingKey {
        case procedureTips = "procedure_tips"
    }
}

// MARK: - ProcedureTip
struct ProcedureTip: Codable, Identifiable {
    let procedureTipID, when: String
    let isBeforeProcedure: Bool
    let question, answer, createdAt: String
    let updatedAt: JSONNull?
    var isExpanded: Bool = false
    
    var id: String {
        return procedureTipID
    }
    
    enum CodingKeys: String, CodingKey {
        case procedureTipID = "procedureTipId"
        case when, isBeforeProcedure, question, answer, createdAt, updatedAt
    }
}
