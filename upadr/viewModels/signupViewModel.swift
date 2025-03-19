import SwiftUI

class SignupViewModel: ObservableObject {
    @Published var isSignupLoading: Bool = false
    @Published var signupData: SignupWithEmailAndPasswordResponseModel?
    @Published var isShowingAlertMessage: Bool = false
    @Published var statusCode: Int?
    
    private let signupURL = "https://dev-api.upadr.com/auth/register"
    
    func hideAlertMessage() {
        isShowingAlertMessage = false
        signupData = nil
    }
    
    
    func signupWithEmailAndPassword(signupWithEmailPasswordModel: SignupWithEmailAndPasswordModel) async {
        await MainActor.run {
            isSignupLoading = true
        }
        
        guard let url = URL(string: signupURL) else {
            print("Invalid URL")
            await MainActor.run {
                isSignupLoading = false
            }
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(signupWithEmailPasswordModel) else {
            print("Failed to encode")
            await MainActor.run {
                isSignupLoading = false
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                await MainActor.run {
                    isSignupLoading = false
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response: \(responseString)")
                do {
                    let response = try JSONDecoder().decode(SignupWithEmailAndPasswordResponseModel.self, from: data)
                    await MainActor.run {
                        isSignupLoading = false
                        signupData = response
                        isShowingAlertMessage = true
                        statusCode = httpResponse.statusCode
                    }
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                    await MainActor.run {
                        isSignupLoading = false
                        signupData = SignupWithEmailAndPasswordResponseModel(message: "Registration completed, but couldn't parse server message")
                        isShowingAlertMessage = true
                    }
                }
            } else {
                print("Failed to encode")
                await MainActor.run {
                    isSignupLoading = false
                }
            }
        } catch {
            print("Signup failed: \(error.localizedDescription)")
            await MainActor.run {
                isSignupLoading = false
                signupData = SignupWithEmailAndPasswordResponseModel(message: "Failed to register")
                isShowingAlertMessage = true
            }
        }
    }
}
