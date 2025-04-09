import SwiftUI

@MainActor
class ForgotPasswordViewModel: ObservableObject {
    @Published var isForgotPasswordLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var forgotPasswordResponseData: ForgotPasswordResponseModel?
    @Published var forgotPasswordErrorData: ForgotPasswordResponseModel?
    
    private var forgotPasswordURL = URL(string: "https://dev-api.upadr.com/auth/forgot-password")!
    
    func resetForgotPasswordViewModel() {
        isForgotPasswordLoading = false
        isError = false
        isSuccess = false
    }
    
    func setResponseData(data: ForgotPasswordResponseModel) {
        isForgotPasswordLoading = false
        isSuccess = true
        forgotPasswordResponseData = data
        isError = false
        forgotPasswordErrorData = nil
    }
    
    func setErrorData(data: ForgotPasswordResponseModel) {
        isForgotPasswordLoading = false
        isError = true
        forgotPasswordErrorData = data
        isSuccess = false
        forgotPasswordResponseData = nil
    }
    
    func forgotPassword(forgotPasswordModel: ForgotPasswordModel) async {
        isForgotPasswordLoading = true
        
        guard let jsonData = try? JSONEncoder().encode(forgotPasswordModel) else {
            print("Failed to encode")
            setErrorData(data: ForgotPasswordResponseModel(message: "Failed to forgot password"))
            return
        }
        
        var request = URLRequest(url: forgotPasswordURL)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setErrorData(data: ForgotPasswordResponseModel(message: "Failed to forgot password"))
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(ForgotPasswordResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {
                    let error = try JSONDecoder().decode(ForgotPasswordResponseModel.self, from: data)
                    print("Error response: \(error)")
                    setErrorData(data: error)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                setErrorData(data: ForgotPasswordResponseModel(message: "Failed to forgot password"))
            }
        } catch {
            print("Forgot password failed: \(error.localizedDescription)")
            setErrorData(data: ForgotPasswordResponseModel(message: "Failed to forgot password"))
        }
    }
}
