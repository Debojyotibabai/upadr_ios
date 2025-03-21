import SwiftUI

@MainActor
class VerifyEmailViewModel: ObservableObject {
    @Published var isVerifyEmailLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var verifyEmailResponseData: VerifyEmailResponseModel?
    @Published var verifyEmailErrorData: VerifyEmailResponseModel?
    
    private let verifyEmailURL = URL(string: "https://dev-api.upadr.com/auth/confirm-account")!
    
    func resetVerifyEmailViewModel() {
        isVerifyEmailLoading = false
        isError = false
        isSuccess = false
        verifyEmailResponseData = nil
        verifyEmailErrorData = nil
    }
    
    func setResponseData(data: VerifyEmailResponseModel) {
        isVerifyEmailLoading = false
        isSuccess = true
        verifyEmailResponseData = data
        isError = false
        verifyEmailErrorData = nil
    }
    
    func setErrorData(data: VerifyEmailResponseModel) {
        isVerifyEmailLoading = false
        isError = true
        verifyEmailErrorData = data
        isSuccess = false
        verifyEmailResponseData = nil
    }
    
    func verifyEmail(verifyEmailModel: VerifyEmailModel) async {
        isVerifyEmailLoading = true
        
        guard let jsonData = try? JSONEncoder().encode(verifyEmailModel) else {
            print("Failed to encode")
            isVerifyEmailLoading = false
            return
        }
        
        var request = URLRequest(url: verifyEmailURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                isVerifyEmailLoading = false
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(VerifyEmailResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setResponseData(data: response)
                } else {
                    let error = try JSONDecoder().decode(VerifyEmailResponseModel.self, from: data)
                    print("Error response: \(error)")
                    setErrorData(data: error)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                setErrorData(data: VerifyEmailResponseModel(message: "OTP verification completed, but couldn't parse server message"))
            }
        } catch {
            print("Otp verification failed: \(error.localizedDescription)")
            setErrorData(data: VerifyEmailResponseModel(message: "Failed to otp verification"))
        }
    }
}
