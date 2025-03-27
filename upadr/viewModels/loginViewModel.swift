import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoginLoading: Bool = false
    @Published var isLoginSuccess: Bool = false
    @Published var isLoginError: Bool = false
    @Published var loginResponseData: LoginWithEmailAndPasswordResponse?
    @Published var loginErrorData: LoginWithEmailAndPasswordError?
    
    private let loginURL = URL(string: "https://dev-api.upadr.com/auth/login")!
    
    func resetLoginViewModel() {
        isLoginLoading = false
        isLoginSuccess = false
        isLoginError = false
        loginResponseData = nil
        loginErrorData = nil
    }
    
    func setResponseData(data: LoginWithEmailAndPasswordResponse) {
        isLoginLoading = false
        isLoginSuccess = true
        loginResponseData = data
        isLoginError = false
        loginErrorData = nil
    }
    
    func setErrorData(data: LoginWithEmailAndPasswordError) {
        isLoginLoading = false
        isLoginError = true
        loginErrorData = data
        isLoginSuccess = false
        loginResponseData = nil
    }
    
    func loginWithEmailAndPassword(loginWithEmailAndPasswordModel: LoginWithEmailAndPasswordModel) async {
        isLoginLoading = true
        
        guard let jsonData = try? JSONEncoder().encode(loginWithEmailAndPasswordModel) else {
            print("Failed to encode")
            isLoginLoading = false
            return
        }
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isLoginLoading = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(LoginWithEmailAndPasswordResponse.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {
                    let error = try JSONDecoder().decode(LoginWithEmailAndPasswordError.self, from: data)
                    print("Error response: \(error)")
                    setErrorData(data: error)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        } catch {
            print("Login failed: \(error.localizedDescription)")
            setErrorData(data: LoginWithEmailAndPasswordError(message: "Failed to login"))
        }
    }
}
