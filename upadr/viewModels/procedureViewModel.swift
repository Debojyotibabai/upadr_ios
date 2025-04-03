import SwiftUI

@MainActor
class ProcedureViewModel: ObservableObject {
    @Published var isFetchingProcedures: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccesss: Bool = false
    @Published var proceduresResponseData: ProcedureResponse?
    
    private var getAllProceduresURL = URL(string: "https://dev-api.upadr.com/procedure/get-all-procedures")!
    
    @AppStorage("token") var token: String?
    
    func resetProcedureViewModel() {
        isFetchingProcedures = false
        isSuccesss = false
        isError = false
        proceduresResponseData = nil
    }
    
    func setResponseData(data: ProcedureResponse) {
        isFetchingProcedures = false
        isSuccesss = true
        proceduresResponseData = data
        isError = false
    }
    
    func fetchAllProcedures() async {
        isFetchingProcedures = true
        
        var request = URLRequest(url: getAllProceduresURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isFetchingProcedures = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(ProcedureResponse.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {}
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        } catch {
            print("Fetch procedures failed: \(error.localizedDescription)")
        }
    }
}
