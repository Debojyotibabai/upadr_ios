import SwiftUI

@MainActor
class LogoutViewModel: ObservableObject {
    @Published var isLoggingOut: Bool = false
    @Published var isErrorWhileLoggingOut: Bool = false
    @Published var isSuccessWhileLoggingOut: Bool = false
    @Published var logoutErrorResponseData: LogoutResponseModel?
    @Published var logoutSuccessResponseData: LogoutResponseModel?
    
    @AppStorage("token") var token: String?
    
    func setLogoutSuccessResponseData(data: LogoutResponseModel?) {
        isLoggingOut = false
        isSuccessWhileLoggingOut = true
        logoutSuccessResponseData = data
        isErrorWhileLoggingOut = false
        logoutErrorResponseData = nil
    }
    
    func setLogoutErrorResponseData(data: LogoutResponseModel?) {
        isLoggingOut = false
        isErrorWhileLoggingOut = true
        logoutErrorResponseData = data
        isSuccessWhileLoggingOut = false
        logoutSuccessResponseData = nil
    }
    
    func logout() async {
        isLoggingOut = true
        
        let logoutURL = URL(string: "https://dev-api.upadr.com/auth/logout")!
        
        var request = URLRequest(url: logoutURL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setLogoutErrorResponseData(data: LogoutResponseModel(message: "Unable to logout"))
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(LogoutResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setLogoutSuccessResponseData(data: response)
                } else {
                    let response = try JSONDecoder().decode(LogoutResponseModel.self, from: data)
                    print("Error response: \(response)")
                    setLogoutErrorResponseData(data: response)
                }
            } catch {
                print("JSON decoding error: \(error)")
                setLogoutErrorResponseData(data: LogoutResponseModel(message: "Unable to logout"))
            }
        } catch {
            print("Logout failed: \(error.localizedDescription)")
            setLogoutErrorResponseData(data: LogoutResponseModel(message: "Unable to logout"))
        }
    }
}
