import SwiftUI

@MainActor
class SignupViewModel: ObservableObject {
    @Published var isSignupLoading: Bool = false
    @Published var signupData: SignupWithEmailAndPasswordResponseModel?
    @Published var isShowingAlertMessage: Bool = false
    @Published var statusCode: Int?
    
    private let signupURL = URL(string: "https://dev-api.upadr.com/auth/register")!
    
    func hideAlertMessage() {
        isShowingAlertMessage = false
        signupData = nil
    }
    
    func signupWithEmailAndPassword(signupWithEmailPasswordModel: SignupWithEmailAndPasswordModel) async {
        isSignupLoading = true
        
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
                    signupData = response
                } else {
                    let error = try JSONDecoder().decode(SignupWithEmailAndPasswordResponseModel.self, from: data)
                    print("Error response: \(error)")
                    signupData = error
                }
                isSignupLoading = false
                statusCode = httpResponse.statusCode
                isShowingAlertMessage = true
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                isSignupLoading = false
                signupData = SignupWithEmailAndPasswordResponseModel(message: "Registration completed, but couldn't parse server message")
                isShowingAlertMessage = true
            }
        } catch {
            print("Signup failed: \(error.localizedDescription)")
            isSignupLoading = false
            signupData = SignupWithEmailAndPasswordResponseModel(message: "Failed to register")
            isShowingAlertMessage = true
        }
    }
}
