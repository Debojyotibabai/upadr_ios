import SwiftUI

@MainActor
class TipViewModel: ObservableObject {
    @Published var selectedProcedureForGetTips: Procedure?
    
    @Published var isFetchingParticularProcedureTips: Bool = false
    @Published var isSuccessWhileFetchingParticularProcedureTips: Bool = false
    @Published var isErrorWhileFetchingParticularProcedureTips: Bool = false
    @Published var particularProcedureTipsResponseData: ParticularProcedureTipsResponseModel?
    
    @AppStorage("token") var token: String?
    
    private var fetchParticularProcedureTipsURL: URL? {
        guard let id = selectedProcedureForGetTips?.id else { return nil }
        return URL(string: "https://dev-api.upadr.com/procedure-tip/get-procedure-tips/\(id)")
    }
    
    func setParticularProcedureTipsResponseData(data: ParticularProcedureTipsResponseModel) {
        isFetchingParticularProcedureTips = false
        isSuccessWhileFetchingParticularProcedureTips = true
        particularProcedureTipsResponseData = data
        isErrorWhileFetchingParticularProcedureTips = false
    }
    
    func setParticularProcedureTipsErrorData() {
        isFetchingParticularProcedureTips = false
        isErrorWhileFetchingParticularProcedureTips = true
        isSuccessWhileFetchingParticularProcedureTips = false
        particularProcedureTipsResponseData = nil
    }
    
    func updateParticularProcedureTipsData(data: ParticularProcedureTipsResponseModel) {
        particularProcedureTipsResponseData = data
    }
    
    func fetchParticularProcedureTips() async {
        isFetchingParticularProcedureTips = true
        
        var request = URLRequest(url: fetchParticularProcedureTipsURL!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setParticularProcedureTipsErrorData()
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(ParticularProcedureTipsResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setParticularProcedureTipsResponseData(data: response)
                } else {
                    setParticularProcedureTipsErrorData()
                }
            } catch {
                print("JSON decoding error: \(error)")
                setParticularProcedureTipsErrorData()
            }
        } catch {
            print("Fetch particular procedure tips failed: \(error.localizedDescription)")
            setParticularProcedureTipsErrorData()
        }
    }
}
