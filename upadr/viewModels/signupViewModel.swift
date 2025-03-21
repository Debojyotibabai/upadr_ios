import SwiftUI

@MainActor
class SignupViewModel: ObservableObject {
    @Published var isSignupLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var signupResponseData: SignupWithEmailAndPasswordResponseModel?
    @Published var signupErrorData: SignupWithEmailAndPasswordResponseModel?
    
    @Published var lastSignedupUserData: SignupWithEmailAndPasswordModel?
    
    private let signupURL = URL(string: "https://dev-api.upadr.com/auth/register")!
    
    func resetSignupViewModel() {
        isSignupLoading = false
        isError = false
        isSuccess = false
        signupResponseData = nil
        signupErrorData = nil
    }
    
    func setResponseData(data: SignupWithEmailAndPasswordResponseModel) {
        isSignupLoading = false
        isSuccess = true
        signupResponseData = data
        isError = false
        signupErrorData = nil
    }
    
    func setErrorData(data: SignupWithEmailAndPasswordResponseModel) {
        isSignupLoading = false
        isError = true
        signupErrorData = data
        isSuccess = false
        signupResponseData = nil
    }
    
    func signupWithEmailAndPassword(signupWithEmailPasswordModel: SignupWithEmailAndPasswordModel) async {
        isSignupLoading = true
        
        lastSignedupUserData = signupWithEmailPasswordModel
        
        guard let jsonData = try? JSONEncoder().encode(signupWithEmailPasswordModel) else {
            print("Failed to encode")
            isSignupLoading = false
            return
        }
        
        var request = URLRequest(url: signupURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isSignupLoading = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(SignupWithEmailAndPasswordResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {
                    let error = try JSONDecoder().decode(SignupWithEmailAndPasswordResponseModel.self, from: data)
                    print("Error response: \(error)")
                    setErrorData(data: error)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                setErrorData(data: SignupWithEmailAndPasswordResponseModel(message: "Registration completed, but couldn't parse server message"))
            }
        } catch {
            print("Signup failed: \(error.localizedDescription)")
            setErrorData(data: SignupWithEmailAndPasswordResponseModel(message: "Failed to register"))
        }
    }
}
