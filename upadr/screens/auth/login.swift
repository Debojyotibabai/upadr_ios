import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var emailAddress:String = ""
    @State var password:String = ""
    
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
                        InputWithoutLabel(placeholder: "email address", text: $emailAddress)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Password")
                        PasswordInputWithoutLabel(placeholder: "password", text: $password)
                        
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
                            SolidButton(text: "Log in", width: geo.size.width * 0.75, onPress: {
                                authViewModel.login()
                            })
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
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AuthViewModel())
}
