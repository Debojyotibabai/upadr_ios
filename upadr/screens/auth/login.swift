import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @AppStorage("token") var token: String?
    
    @State var emailAddress:String = ""
    @State var password:String = ""
    
    @State var isEmailAddressValid: Bool = false
    @State var isPasswordValid: Bool = false
    
    var isFormValid: Bool {
        return isEmailAddressValid && isPasswordValid
    }
    
    func loginWithEmailAndPassword() async {
        await loginViewModel.loginWithEmailAndPassword(loginWithEmailAndPasswordModel:
                                                        LoginWithEmailAndPasswordModel(emailAddress: emailAddress,
                                                                                       password: password))
        
        if (loginViewModel.isLoginSuccess) {
            token = loginViewModel.loginResponseData?.tokens.accessToken
        }
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
                        
                        Heading(text: "Login")
                        
                        Spacer().frame(height: 13)
                        
                        SubHeading(text: "Please enter your email and password or log in with social media",
                                   foregroundColor: .gray1)
                        
                        Spacer().frame(height: 25)
                        
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
                        }
                        
                        Spacer().frame(height: 15)
                        
                        HStack {
                            Spacer()
                            Text("Forgot Password?")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.deepSky)
                                .onTapGesture {
                                    authViewModel.authNavigationPath.append(AuthScreens.forgotPassword)
                                }
                        }
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Log in",
                                        width: geo.size.width * 0.75,
                                        onPress: {
                                Task {
                                    await loginWithEmailAndPassword()
                                }
                            },
                                        isDisabled: !isFormValid,
                                        isLoading: loginViewModel.isLoginLoading)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height: 30)
                        
                        HStack {
                            Spacer()
                            HStack {
                                Text("Don't have an account yet?")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray1)
                                
                                Text("Sign up")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.deepSky)
                                    .onTapGesture {
                                        authViewModel.authNavigationPath = NavigationPath()
                                        authViewModel.authNavigationPath.append(AuthScreens.signup)
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
            .alert(loginViewModel.loginErrorData?.message ?? "Something went wrong",
                   isPresented: $loginViewModel.isLoginError) {
                Button {
                    loginViewModel.resetLoginViewModel()
                } label: {
                    Text("Okay")
                }
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(LoginViewModel())
        .environmentObject(AuthViewModel())
}
