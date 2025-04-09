import SwiftUI

@MainActor
class CreateNewPasswordViewModel: ObservableObject {
    @Published var isCreateNewPasswordLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var createNewPasswordResponseData: CreateNewPasswordResponseModel?
    @Published var createNewPasswordErrorData: CreateNewPasswordResponseModel?
    
    private var createNewPasswordURL = URL(string: "https://dev-api.upadr.com/auth/reset-password")!
    
    func resetCreateNewPasswordViewModel() {
        isCreateNewPasswordLoading = false
        isError = false
        isSuccess = false
    }
    
    func setResponseData(data: CreateNewPasswordResponseModel) {
        isCreateNewPasswordLoading = false
        isSuccess = true
        createNewPasswordResponseData = data
        isError = false
        createNewPasswordErrorData = nil
    }
    
    func setErrorData(data: CreateNewPasswordResponseModel) {
        isCreateNewPasswordLoading = false
        isError = true
        createNewPasswordErrorData = data
        isSuccess = false
        createNewPasswordResponseData = nil
    }
    
    func createNewPAssword(createNewPasswordModel: CreateNewPasswordModel) async {
        isCreateNewPasswordLoading = true
        
        guard let jsonData = try? JSONEncoder().encode(createNewPasswordModel) else {
            print("Failed to encode")
            setErrorData(data: CreateNewPasswordResponseModel(message: "Failed to reset password"))
            return
        }
        
        var request = URLRequest(url: createNewPasswordURL)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setErrorData(data: CreateNewPasswordResponseModel(message: "Failed to reset password"))
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(CreateNewPasswordResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {
                    let error = try JSONDecoder().decode(CreateNewPasswordResponseModel.self, from: data)
                    print("Error response: \(error)")
                    setErrorData(data: error)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                setErrorData(data: CreateNewPasswordResponseModel(message: "Failed to reset password"))
            }
        } catch {
            print("Create new password failed: \(error.localizedDescription)")
            setErrorData(data: CreateNewPasswordResponseModel(message: "Failed to reset password"))
        }
    }
}
