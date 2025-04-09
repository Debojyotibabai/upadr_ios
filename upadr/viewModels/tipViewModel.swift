import SwiftUI

@MainActor
class TipViewModel: ObservableObject {
    @Published var selectedProcedureForGetTips: Procedure?
    
    @Published var isFetchingParticularProcedureTips: Bool = false
    @Published var isSuccessWhileFetchingParticularProcedureTips: Bool = false
    @Published var isErrorWhileFetchingParticularProcedureTips: Bool = false
    @Published var particularProcedureTipsResponseData: ParticularProcedureTipsResponseModel?
    
    func setParticularProcedureTipsResponseData(data: ParticularProcedureTipsResponseModel) {
        
    }
}
