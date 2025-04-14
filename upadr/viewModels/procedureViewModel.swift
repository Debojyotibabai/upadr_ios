import SwiftUI

@MainActor
class ProcedureViewModel: ObservableObject {
    @Published var isFetchingAllProcedures: Bool = false
    @Published var isErrorWhileFetchingAllProcedure: Bool = false
    @Published var isSuccessWhileFetchingAllProcedure: Bool = false
    @Published var allProceduresResponseData: AllProcedureResponseModel?
    
    @Published var isCreatingProcedure: Bool = false
    @Published var isErrorWhileCreatingProcedure: Bool = false
    @Published var isSuccessWhileCreatingProcedure: Bool = false
    @Published var createProcedureResponseData: CreateProcedureResponseModel?
    @Published var createProcedureErrorData: CreateProcedureErrorModel?
    
    @Published var selectedProcedureToGetDetails: UserProcedure?
    
    @Published var isFetchingParticularProcedureDetails: Bool = false
    @Published var isErrorWhileFetchingParticularProcedureDetails: Bool = false
    @Published var isSuccessWhileFetchingParticularProcedureDetails: Bool = false
    @Published var particularProcedureDetailsResponseData: ParticularProcedureDetailsResponseModel?
    
    @Published var selectedStepTitleOfParticularProcedure: String?
    @Published var selectedStepOfParticularProcedure: Step?
    
    @Published var isEditingProcedure: Bool = false
    @Published var isErrorWhileEditingProcedure: Bool = false
    @Published var isSuccessWhileEditingProcedure: Bool = false
    @Published var editProcedureResponseData: CreateProcedureResponseModel?
    @Published var editProcedureErrorData: CreateProcedureErrorModel?
    
    private var getAllProceduresURL = URL(string: "https://dev-api.upadr.com/user-procedure/get-user-procedures")!
    private var createProcedureURL = URL(string: "https://dev-api.upadr.com/user-procedure/create-user-procedure")!
    
    @AppStorage("token") var token: String?
    
    func updateSelectedProcedureToGetDetails(procedure: UserProcedure?) {
        selectedProcedureToGetDetails = procedure
    }
    
    func updateSelectedStepOfParticularProcedure(step: Step, stepTitle: String) {
        selectedStepTitleOfParticularProcedure = stepTitle
        selectedStepOfParticularProcedure = step
    }
    
    func setCreateProcedureResponseData(data: CreateProcedureResponseModel) {
        isCreatingProcedure = false
        isSuccessWhileCreatingProcedure = true
        createProcedureResponseData = data
        isErrorWhileCreatingProcedure = false
        createProcedureErrorData = nil
    }
    
    func setCreateProcedureErrorData(data: CreateProcedureErrorModel) {
        isCreatingProcedure = false
        isErrorWhileCreatingProcedure = true
        createProcedureErrorData = data
        isSuccessWhileCreatingProcedure = false
        createProcedureResponseData = nil
    }
    
    func resetCreateProcedureData() {
        isCreatingProcedure = false
        isErrorWhileCreatingProcedure = false
        isSuccessWhileCreatingProcedure = false
        createProcedureResponseData = nil
        createProcedureErrorData = nil
    }
    
    func setAllProcedureResponseData(data: AllProcedureResponseModel) {
        isFetchingAllProcedures = false
        isSuccessWhileFetchingAllProcedure = true
        allProceduresResponseData = data
        isErrorWhileFetchingAllProcedure = false
    }
    
    func setAllProcedureErrorData() {
        isFetchingAllProcedures = false
        isErrorWhileFetchingAllProcedure = true
        isSuccessWhileFetchingAllProcedure = false
        allProceduresResponseData = nil
    }
    
    func setParticularProcedureDetailsResponseData(data: ParticularProcedureDetailsResponseModel) {
        isFetchingParticularProcedureDetails = false
        isSuccessWhileFetchingParticularProcedureDetails = true
        particularProcedureDetailsResponseData = data
        isErrorWhileFetchingParticularProcedureDetails = false
    }
    
    func setParticularProcedureDetailsErrorData() {
        isFetchingParticularProcedureDetails = false
        isErrorWhileFetchingParticularProcedureDetails = true
        isSuccessWhileFetchingParticularProcedureDetails = false
        particularProcedureDetailsResponseData = nil
    }
    
    func setEditProcedureResponseData(data: CreateProcedureResponseModel) {
        isEditingProcedure = false
        isSuccessWhileEditingProcedure = true
        editProcedureResponseData = data
        isErrorWhileEditingProcedure = false
        editProcedureErrorData = nil
    }
    
    func setEditProcedureErrorData(data: CreateProcedureErrorModel) {
        isEditingProcedure = false
        isErrorWhileEditingProcedure = true
        editProcedureErrorData = data
        isSuccessWhileEditingProcedure = false
        editProcedureResponseData = nil
    }
    
    func createProcedure(createProcedureRequestModel: CreateProcedureRequestModel) async {
        isCreatingProcedure = true
        
        guard let jsonData = try? JSONEncoder().encode(createProcedureRequestModel) else {
            print("Failed to encode")
            setCreateProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to create procedure"))
            return
        }
        
        var request = URLRequest(url: createProcedureURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data,response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setCreateProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to create procedure"))
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(CreateProcedureResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setCreateProcedureResponseData(data: response)
                } else {
                    let response = try JSONDecoder().decode(CreateProcedureErrorModel.self, from: data)
                    print("Error response: \(response)")
                    setCreateProcedureErrorData(data: response)
                }
            } catch {
                print("JSON decoding error: \(error)")
                setCreateProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to create procedure"))
            }
        } catch {
            print("Create procedure failed: \(error.localizedDescription)")
            setCreateProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to create procedure"))
        }
    }
    
    func fetchAllProcedures() async {
        isFetchingAllProcedures = true
        
        var request = URLRequest(url: getAllProceduresURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setAllProcedureErrorData()
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(AllProcedureResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setAllProcedureResponseData(data: response)
                } else {
                    setAllProcedureErrorData()
                }
            } catch {
                print("JSON decoding error: \(error)")
                setAllProcedureErrorData()
            }
        } catch {
            print("Fetch all procedures failed: \(error.localizedDescription)")
            setAllProcedureErrorData()
        }
    }
    
    func fetchParticularProcedureDetails(userProcedureId: String) async {
        isFetchingParticularProcedureDetails = true
        
        let getParticularProcedureDetailsURL = URL(string: "https://dev-api.upadr.com/user-procedure/get-user-procedure/\(userProcedureId)")!
        
        var request = URLRequest(url: getParticularProcedureDetailsURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setParticularProcedureDetailsErrorData()
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(ParticularProcedureDetailsResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setParticularProcedureDetailsResponseData(data: response)
                } else {
                    setParticularProcedureDetailsErrorData()
                }
            } catch {
                print("JSON decoding error: \(error)")
                setParticularProcedureDetailsErrorData()
            }
        } catch {
            print("Fetch particular procedure details failed: \(error.localizedDescription)")
            setParticularProcedureDetailsErrorData()
        }
    }
    
    func editParticularProcedure(editProcedureRequestModel: CreateProcedureRequestModel, userProcedureId: String) async {
        isEditingProcedure = true
        
        let editParticularProcedureURL = URL(string: "https://dev-api.upadr.com/user-procedure/update-user-procedure/\(userProcedureId)")!
        
        guard let jsonData = try? JSONEncoder().encode(editProcedureRequestModel) else {
            print("Failed to encode")
            setCreateProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to edit procedure"))
            return
        }
        
        var request = URLRequest(url: editParticularProcedureURL)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data,response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                setEditProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to edit procedure"))
                return
            }
            
            do {
                if((200...399).contains(httpResponse.statusCode)) {
                    let response = try JSONDecoder().decode(CreateProcedureResponseModel.self, from: data)
                    print("Success response: \(response)")
                    setEditProcedureResponseData(data: response)
                } else {
                    let response = try JSONDecoder().decode(CreateProcedureErrorModel.self, from: data)
                    print("Error response: \(response)")
                    setEditProcedureErrorData(data: response)
                }
            } catch {
                print("JSON decoding error: \(error)")
                setEditProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to edit procedure"))
            }
        } catch {
            print("Edit procedure failed: \(error.localizedDescription)")
            setEditProcedureErrorData(data: CreateProcedureErrorModel(message: "Failed to edit procedure"))
        }
    }
}
