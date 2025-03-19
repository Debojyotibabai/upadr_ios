import SwiftUI

struct SignupScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var signupViewModel: SignupViewModel = SignupViewModel()
    
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var emailAddress:String = ""
    @State var password:String = ""
    @State var confirmPassword:String = ""
    
    @State var isFirstNameValid: Bool = false
    @State var isLastNameValid: Bool = false
    @State var isEmailAddressValid: Bool = false
    @State var isPasswordValid: Bool = false
    @State var isConfirmPasswordValid: Bool = false
    
    var isFormValid: Bool {
        return isFirstNameValid &&
        isLastNameValid &&
        isEmailAddressValid &&
        isPasswordValid &&
        isConfirmPasswordValid
    }
    
    func signupWithEmailAndPassword() async {
        await signupViewModel.signupWithEmailAndPassword(signupWithEmailPasswordModel: SignupWithEmailAndPasswordModel(confirmPassword: confirmPassword, emailAddress: emailAddress, firstName: firstName, lastName: lastName, password: password))
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    Image(.logoWithName)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height * 0.35)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 25)
                        
                        Heading(text: "Sign up")
                        
                        Spacer().frame(height: 13)
                        
                        SubHeading(text: "Please enter your email and password or sign up with social media",
                                   foregroundColor: .gray1)
                        
                        Spacer().frame(height: 25)
                        
                        InputLabel(text: "Full Name")
                        HStack(alignment: .top) {
                            InputWithoutLabel(placeholder: "first name",
                                              text: $firstName,
                                              errorMessage: isFirstNameValid ? "" : "Required")
                            .onChange(of: firstName) { oldValue, newValue in
                                if (newValue != "") {
                                    isFirstNameValid = true
                                }
                            }
                            InputWithoutLabel(placeholder: "last name",
                                              text: $lastName,
                                              errorMessage: isLastNameValid ? "" : "Required")
                            .onChange(of: lastName) { oldValue, newValue in
                                if (newValue != "") {
                                    isLastNameValid = true
                                }
                            }
                        }
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Email")
                        InputWithoutLabel(placeholder: "email address",
                                          text: $emailAddress,
                                          errorMessage: isEmailAddressValid ? "" : "Enter a valid email address")
                        .onChange(of: emailAddress) { oldValue, newValue in
                            isEmailAddressValid = NSPredicate(format: "SELF MATCHES %@", #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#).evaluate(with: newValue)
                        }
                        
                        Spacer().frame(height: 20)
                        
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
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Sign up", width: geo.size.width * 0.75, onPress: {
                                Task {
                                    await signupWithEmailAndPassword()
                                }
                            },
                                        isDisabled: !isFormValid,
                                        isLoading: signupViewModel.isSignupLoading)
                            Spacer()
                        }
                        
                        Spacer().frame(height: 30)
                        
                        HStack {
                            Spacer()
                            HStack {
                                Text("Already have an account?")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray1)
                                
                                Text("Log in")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.deepSky)
                                    .onTapGesture {
                                        authViewModel.authNavigationPath = NavigationPath()
                                        authViewModel.authNavigationPath.append(AuthScreens.login)
                                    }
                            }
                            Spacer()
                        }
                        
                        Spacer().frame(height: 10)
                    }
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height,
                       alignment: .topLeading)
                .padding(.horizontal, 25)
                .background(.white)
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height,
                   alignment: .top)
            .background(.lightSky)
            .alert(signupViewModel.signupResponseData?.message ?? "",
                   isPresented: $signupViewModel.isSuccess) {
                Button {
                    authViewModel.authNavigationPath.append(AuthScreens.verifyAccount)
                    signupViewModel.resetSignupViewModel()
                } label: {
                    Text("Verify Email")
                }
            }
                   .alert(signupViewModel.signupErrorData?.message ?? "",
                          isPresented: $signupViewModel.isError) {
                       Button {
                           signupViewModel.resetSignupViewModel()
                       } label: {
                           Text("Okay")
                       }
                   }
        }
    }
}

#Preview {
    SignupScreen()
        .environmentObject(AuthViewModel())
}
