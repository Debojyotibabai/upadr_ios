import SwiftUI

@MainActor
class ProcedureViewModel: ObservableObject {
    @Published var isFetchingAllProcedures: Bool = false
    @Published var isErrorWhileFetchingAllProcedure: Bool = false
    @Published var isSuccessWhileFetchingAllProcedure: Bool = false
    @Published var allProceduresResponseData: AllProcedureResponseModel?
    
    @Published var isCreatingProcedure: Bool = false
    @Published var isErrorWhileCreatingProcedure: Bool = false
    @Published var isSuccessWhileCreatingProcedure: Bool = false
    @Published var createProcedureResponseData: CreateProcedureResponseModel?
    @Published var createProcedureErrorData: CreateProcedureErrorModel?
    
    private var getAllProceduresURL = URL(string: "https://dev-api.upadr.com/user-procedure/get-user-procedures")!
    private var createProcedureURL = URL(string: "https://dev-api.upadr.com/user-procedure/create-user-procedure")!
    
    @AppStorage("token") var token: String?
    
    func setCreateProcedureResponseData(data: CreateProcedureResponseModel) {
        isCreatingProcedure = false
        isSuccessWhileCreatingProcedure = true
        createProcedureResponseData = data
        isErrorWhileCreatingProcedure = false
        createProcedureErrorData = nil
    }
    
    func setCreateProcedureErrorData(data: CreateProcedureErrorModel) {
        isCreatingProcedure = false
        isErrorWhileCreatingProcedure = true
        createProcedureErrorData = data
        isSuccessWhileCreatingProcedure = false
        createProcedureResponseData = nil
    }
    
    func setAllProcedureResponseData(data: AllProcedureResponseModel) {
        isFetchingAllProcedures = false
        isSuccessWhileFetchingAllProcedure = true
        allProceduresResponseData = data
        isErrorWhileFetchingAllProcedure = false
    }
    
    func resetCreateProcedureData() {
        isCreatingProcedure = false
        isErrorWhileCreatingProcedure = false
        isSuccessWhileCreatingProcedure = false
        createProcedureResponseData = nil
        createProcedureErrorData = nil
    }
    
    func createProcedure(createProcedureRequestModel: CreateProcedureRequestModel) async {
        isCreatingProcedure = true
        
        guard let jsonData = try? JSONEncoder().encode(createProcedureRequestModel) else {
            print("Failed to encode")
            isCreatingProcedure = false
            return
        }
        
        var request = URLRequest(url: createProcedureURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data,response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isCreatingProcedure = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(CreateProcedureResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setCreateProcedureResponseData(data: response)
                } else {
                    let response = try JSONDecoder().decode(CreateProcedureErrorModel.self, from: data)
                    print("Error response: \(response)")
                    setCreateProcedureErrorData(data: response)
                }
            } catch {
                print("JSON decoding error: \(error)")
                isFetchingAllProcedures = false
            }
        } catch {
            print("Create procedure failed: \(error.localizedDescription)")
            isCreatingProcedure = false
        }
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
                    let response = try JSONDecoder().decode(AllProcedureResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setAllProcedureResponseData(data: response)
                } else {}
            } catch {
                print("JSON decoding error: \(error)")
                isFetchingAllProcedures = false
            }
        } catch {
            print("Fetch all procedures failed: \(error.localizedDescription)")
            isFetchingAllProcedures = false
        }
    }
}
