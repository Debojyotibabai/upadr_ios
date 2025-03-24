import SwiftUI

struct ForgotPasswordScreen: View {
    @StateObject var forgotPasswordViewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var authUser: AuthUser
    
    @State var emailAddress: String = ""
    
    @State var isEmailAddressValid: Bool = false
    
    var isFormValid: Bool {
        return isEmailAddressValid
    }
    
    func forgotPassword() async {
        await forgotPasswordViewModel.forgotPassword(forgotPasswordModel:
                                                        ForgotPasswordModel(emailAddress:
                                                                                emailAddress))
        
        if(forgotPasswordViewModel.isSuccess) {
            authUser.forgotPasswordEmailAddress = emailAddress
            authViewModel.authNavigationPath.append(AuthScreens.createNewPassword)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .fontWeight(.medium)
                        .onTapGesture {
                            authViewModel.authNavigationPath.removeLast()
                        }
                    
                    Spacer()
                }
                
                Spacer().frame(height: 50)
                
                Image(.logoWithName)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                
                Spacer().frame(height: 100)
                
                VStack(alignment: .leading) {
                    Heading(text: "Forgot Your Password?")
                    
                    Spacer().frame(height: 13)
                    
                    SubHeading(text: "Please enter the email or phone number you signed up with to reset your password",
                               foregroundColor: .gray1)
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                
                Spacer().frame(height: 80)
                
                InputWithoutLabel(placeholder: "email address",
                                  text: $emailAddress,
                                  errorMessage: isEmailAddressValid ? "" : "Enter a valid email address")
                .onChange(of: emailAddress) { oldValue, newValue in
                    isEmailAddressValid = NSPredicate(format: "SELF MATCHES %@", #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#).evaluate(with: newValue)
                }
                
                Spacer()
                
                SolidButton(text: "Send Code", width: geo.size.width * 0.75, onPress: {
                    Task {
                        await forgotPassword()
                    }
                },
                            isDisabled: !isFormValid,
                            isLoading: forgotPasswordViewModel.isForgotPasswordLoading)
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height,
                   alignment: .topLeading)
            .padding(25)
        }
        .alert(forgotPasswordViewModel.forgotPasswordErrorData?.message ?? "Something went wrong",
               isPresented: $forgotPasswordViewModel.isError) {
            Button {
                forgotPasswordViewModel.resetForgotPasswordViewModel()
            } label: {
                Text("Okay")
            }
        }
    }
}

#Preview {
    ForgotPasswordScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(AuthUser())
}
