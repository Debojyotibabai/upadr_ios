import SwiftUI

class SignupViewModel: ObservableObject {
    @Published var isSignupLoading: Bool = false
    @Published var alertMessage: String = ""
    @Published var isShowingAlertMessage: Bool = false
    
    private let signupURL = "https://dev-api.upadr.com/auth/register"
    
    func hideAlertMessage() {
        isShowingAlertMessage = false
        alertMessage = ""
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
            
            let statusCode = httpResponse.statusCode
            print("Response status code: \(statusCode)")
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response: \(responseString)")
                do {
                    let response = try JSONDecoder().decode(SignupWithEmailAndPasswordResponseModel.self, from: data)
                    print("Message from server: \(response.message)")
                    
                    await MainActor.run {
                        isSignupLoading = false
                        alertMessage = response.message
                        isShowingAlertMessage = true
                    }
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                    await MainActor.run {
                        isSignupLoading = false
                        alertMessage = "Registration completed, but couldn't parse server message"
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
                alertMessage = "Failed to register"
                isShowingAlertMessage = true
            }
        }
    }
}
