import SwiftUI

@MainActor
class ChooseProcedureViewModel: ObservableObject {
    @Published var isFetchingAllProcedures: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var allProceduresResponseData: ChooseProcedureResponse?
    
    @Published var selectedProcedure: String?
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: Date = Date()
    
    private var getAllProceduresURL = URL(string: "https://dev-api.upadr.com/procedure/get-all-procedures")!
    
    @AppStorage("token") var token: String?
    
    func setResponseData(data: ChooseProcedureResponse) {
        isFetchingAllProcedures = false
        isSuccess = true
        allProceduresResponseData = data
        isError = false
    }
    
    func setErrorData() {
        isFetchingAllProcedures = false
        isError = true
        isSuccess = false
        allProceduresResponseData = nil
    }
    
    func fetchAllProcedures() async {
        isFetchingAllProcedures = true
        
        var request = URLRequest(url: getAllProceduresURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isFetchingAllProcedures = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(ChooseProcedureResponse.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {
                    setErrorData()
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                isFetchingAllProcedures = false
            }
        } catch {
            print("Fetch all procedures failed: \(error.localizedDescription)")
            isFetchingAllProcedures = false
        }
    }
}
