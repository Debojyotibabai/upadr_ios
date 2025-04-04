import SwiftUI

@MainActor
class MyProcedureViewModel: ObservableObject {
    @Published var isFetchingMyAllProcedures: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var myAllProceduresResponseData: ChooseProcedureResponse?
    
    private var getMyAllProceduresURL = URL(string: "https://dev-api.upadr.com/procedure/get-all-procedures")!
    
    @AppStorage("token") var token: String?
    
    func resetMyProcedureViewModel() {
        isFetchingMyAllProcedures = false
        isSuccess = false
        isError = false
        myAllProceduresResponseData = nil
    }
    
    func setResponseData(data: ChooseProcedureResponse) {
        isFetchingMyAllProcedures = false
        isSuccess = true
        myAllProceduresResponseData = data
        isError = false
    }
    
    func fetchMyAllProcedures() async {
        isFetchingMyAllProcedures = true
        
        var request = URLRequest(url: getMyAllProceduresURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isFetchingMyAllProcedures = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(ChooseProcedureResponse.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {}
            } catch {
                print("JSON decoding error: \(error)")
                isFetchingMyAllProcedures = false
            }
        } catch {
            print("Fetch my all procedures failed: \(error.localizedDescription)")
            isFetchingMyAllProcedures = false
        }
    }
}
