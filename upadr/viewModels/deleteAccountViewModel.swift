import SwiftUI

@MainActor
class DeleteAccountViewModel: ObservableObject {
    @Published var isDeletingAccount: Bool = false
    @Published var isErrorWhileDeletingAccount: Bool = false
    @Published var isSuccessWhileDeletingAccount: Bool = false
    @Published var deleteAccountErrorResponseData: DeleteAccountResponseModel?
    @Published var deleteAccountSuccessResponseData: DeleteAccountResponseModel?
    
    @AppStorage("token") var token: String?
    
    func setDeleteAccountSuccessResponseData(data: DeleteAccountResponseModel?) {
        isDeletingAccount = false
        isSuccessWhileDeletingAccount = true
        deleteAccountSuccessResponseData = data
        isErrorWhileDeletingAccount = false
        deleteAccountErrorResponseData = nil
    }
    
    func setDeleteAccountErrorResponseData(data: DeleteAccountResponseModel?) {
        isDeletingAccount = false
        isErrorWhileDeletingAccount = true
        deleteAccountErrorResponseData = data
        isSuccessWhileDeletingAccount = false
        deleteAccountSuccessResponseData = nil
    }
    
    func deleteAccount() async {
        isDeletingAccount = true
        
        let deleteAccountURL = URL(string: "https://dev-api.upadr.com/auth/delete-account")!
        
        var request = URLRequest(url: deleteAccountURL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setDeleteAccountErrorResponseData(data: DeleteAccountResponseModel(message: "Unable to delete account"))
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(DeleteAccountResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setDeleteAccountSuccessResponseData(data: response)
                } else {
                    let response = try JSONDecoder().decode(DeleteAccountResponseModel.self, from: data)
                    print("Error response: \(response)")
                    setDeleteAccountErrorResponseData(data: response)
                }
            } catch {
                print("JSON decoding error: \(error)")
                setDeleteAccountErrorResponseData(data: DeleteAccountResponseModel(message: "Unable to delete account"))
            }
        } catch {
            print("Delete account failed: \(error.localizedDescription)")
            setDeleteAccountErrorResponseData(data: DeleteAccountResponseModel(message: "Unable to delete account"))
        }
    }
}
