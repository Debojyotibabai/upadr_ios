import SwiftUI

struct CreateNewPasswordScreen: View {
    @EnvironmentObject var forgotPasswordViewModel: ForgotPasswordViewModel
    @EnvironmentObject var createNewPasswordViewModel: CreateNewPasswordViewModel
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var authUserViewModel: AuthUserViewModel
    
    @State var otp: [String] = Array(repeating: "", count: 6)
    @FocusState var focusedField: Int?
    
    @State var password:String = ""
    @State var confirmPassword:String = ""
    
    @State var isPasswordValid: Bool = false
    @State var isConfirmPasswordValid: Bool = false
    
    var isFormValid: Bool {
        return otp.joined().count == 6 && isPasswordValid && isConfirmPasswordValid
    }
    
    func handleInputChange(_ newValue: String, _ index: Int) {
        // Limit to one character
        if newValue.count > 1 {
            otp[index] = String(newValue.prefix(1))
        }
        
        // Move focus to next field if valid
        if !newValue.isEmpty {
            if index < 5 {
                focusedField = index + 1
            } else {
                focusedField = nil // Last digit entered, dismiss keyboard
            }
        } else {
            if index > 0 {
                focusedField = index - 1 // Move focus back on delete
            }
        }
    }
    
    func resendOtp() async {
        await forgotPasswordViewModel.forgotPassword(forgotPasswordModel: authUserViewModel.lastForgotPasswordFormData!)
    }
    
    func resetPassword() async {
        guard let emailAddress = authUserViewModel.lastForgotPasswordFormData?.emailAddress else {
            return
        }
        
        await createNewPasswordViewModel.createNewPAssword(createNewPasswordModel:
                                                            CreateNewPasswordModel(confirmPassword: confirmPassword,
                                                                                   emailAddress: emailAddress,
                                                                                   newPassword: password,
                                                                                   resetCode: otp.joined()))
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
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
                        Heading(text: "Create New Password")
                        
                        Spacer().frame(height: 13)
                        
                        SubHeading(text: "Please enter the 6 digit code sent to \(authUserViewModel.lastForgotPasswordFormData?.emailAddress ?? "your email")",
                                   foregroundColor: .gray1)
                    }
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    
                    Spacer().frame(height: 80)
                    
                    OtpInputWithoutLabel(otp: $otp,
                                         focusedField: $focusedField,
                                         handleInputChange: handleInputChange)
                    
                    Spacer().frame(height: 40)
                    
                    HStack {
                        Text("Didn’t receive the code?")
                            .font(.system(size: 18))
                            .foregroundColor(.gray1)
                        
                        Text("Resend")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.deepSky)
                            .onTapGesture {
                                Task {
                                    await resendOtp()
                                }
                            }
                            .disabled(forgotPasswordViewModel.isForgotPasswordLoading)
                    }
                    
                    Spacer().frame(height: 40)
                    
                    VStack(alignment: .leading) {
                        SubHeading(text: "Your new password must be different from your previously used password",
                                   foregroundColor: .gray1)
                        
                        Spacer().frame(height: 30)
                        
                        InputLabel(text: "Password")
                        PasswordInputWithoutLabel(placeholder: "password",
                                                  text: $password,
                                                  errorMessage: isPasswordValid ? "" : "Password must be 8+ chars, include a letter & number")
                        .onChange(of: password) { oldValue, newValue in
                            isPasswordValid = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])[A-Za-z\\d!@#$%^&*(),.?\":{}|<>]{8,}$").evaluate(with: newValue)
                            isConfirmPasswordValid = confirmPassword == newValue
                        }
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Confirm Password")
                        PasswordInputWithoutLabel(placeholder: "confirm password",
                                                  text: $confirmPassword,
                                                  errorMessage: isConfirmPasswordValid ? "" : "Passwords must match")
                        .onChange(of: confirmPassword) { oldValue, newValue in
                            isConfirmPasswordValid = password == newValue
                        }
                    }
                    .frame(minWidth: 0,
                           maxWidth: geo.size.width)
                    
                    Spacer().frame(height: 50)
                    
                    SolidButton(text: "Confirm", width: geo.size.width * 0.75, onPress: {
                        Task {
                            await resetPassword()
                        }
                    },
                                isDisabled: !isFormValid,
                                isLoading: createNewPasswordViewModel.isCreateNewPasswordLoading)
                    
                    Spacer().frame(height: 10)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height,
                   alignment: .topLeading)
            .padding(.horizontal, 25)
            .padding(.top, 25)
            .alert(forgotPasswordViewModel.forgotPasswordErrorData?.message ?? "Something went wrong",
                   isPresented: $forgotPasswordViewModel.isError) {
                Button {
                    forgotPasswordViewModel.resetForgotPasswordViewModel()
                } label: {
                    Text("Okay")
                }
            }
                   .alert(forgotPasswordViewModel.forgotPasswordResponseData?.message ?? "OTP has been sent successfully",
                          isPresented: $forgotPasswordViewModel.isSuccess) {
                       Button {
                           forgotPasswordViewModel.resetForgotPasswordViewModel()
                       } label: {
                           Text("Okay")
                       }
                   }
                          .alert(createNewPasswordViewModel.createNewPasswordErrorData?.message ?? "Something went wrong",
                                 isPresented: $createNewPasswordViewModel.isError) {
                              Button {
                                  createNewPasswordViewModel.resetCreateNewPasswordViewModel()
                              } label: {
                                  Text("Okay")
                              }
                          }
                                 .alert(createNewPasswordViewModel.createNewPasswordResponseData?.message ?? "Password reset successfully",
                                        isPresented: $createNewPasswordViewModel.isSuccess) {
                                     Button {
                                         createNewPasswordViewModel.resetCreateNewPasswordViewModel()
                                         authViewModel.authNavigationPath = NavigationPath()
                                         authViewModel.authNavigationPath.append(AuthScreens.login)
                                     } label: {
                                         Text("Go to Login")
                                     }
                                 }
        }
    }
}

#Preview {
    CreateNewPasswordScreen()
        .environmentObject(ForgotPasswordViewModel())
        .environmentObject(CreateNewPasswordViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(AuthUserViewModel())
}
