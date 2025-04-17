import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var deleteAccountViewModel: DeleteAccountViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var isDeleteAccountModalVisible: Bool = false
    
    @AppStorage("token") var token: String?
    
    let settingsOptions: [String] = ["Terms and Conditions",
                                     "Privacy Policy",
                                     "Contact Us",
                                     "Rate App",
                                     "Accessibility",
                                     "Schedule New Procedure",
                                     "Change Password"]
    
    func deleteAccount() async {
        await deleteAccountViewModel.deleteAccount()
        
        isDeleteAccountModalVisible = false
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                Heading(text: "Settings")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                Text("Debojyoti Ghosh")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.gray2)
                    .padding()
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    .background(.gray5)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(settingsOptions, id: \.self) { item in
                            VStack {
                                HStack {
                                    Text(item)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.gray2)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 10)
                                
                                Divider()
                            }
                            .padding(.horizontal, 25)
                        }
                    }
                }
                
                VStack {
                    SolidButton(text: "Delete Account",
                                backgroundColor: .deepRed,
                                onPress: {
                        isDeleteAccountModalVisible = true
                    })
                    .frame(minWidth: 0, maxWidth: geo.size.width * 0.8)
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
            }
            
            if(isDeleteAccountModalVisible) {
                DeleteAccountModal(parentGeoWidth: geo.size.width,
                                   isDeleteAccountModalVisible: $isDeleteAccountModalVisible,
                                   onDeleteAccount: {
                    Task {
                        await deleteAccount()
                    }
                },
                                   isDeletingAccount: deleteAccountViewModel.isDeletingAccount)
            }
        }
        .alert(deleteAccountViewModel.deleteAccountErrorResponseData?.message ?? "Something went wrong",
               isPresented: $deleteAccountViewModel.isErrorWhileDeletingAccount) {
            Button {
                isDeleteAccountModalVisible = true
            } label: {
                Text("Try again")
            }
        }
               .alert(deleteAccountViewModel.deleteAccountSuccessResponseData?.message ?? "Account deleted successfully",
                      isPresented: $deleteAccountViewModel.isSuccessWhileDeletingAccount) {
                   Button {
                       token = nil
                       
                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                           authViewModel.resetAuthViewModel()
                           appViewModel.resetAppViewModel()
                       }
                   } label: {
                       Text("Okay")
                   }
                   
               }
    }
}


#Preview {
    SettingsScreen()
        .environmentObject(AppViewModel())
        .environmentObject(DeleteAccountViewModel())
        .environmentObject(AuthViewModel())
}
