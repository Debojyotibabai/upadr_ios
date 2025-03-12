import SwiftUI

struct LoginScreen: View {
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
                        
                        PrimaryHeading(text: "Login")
                        
                        Spacer().frame(height: 13)
                        
                        PrimarySubHeading(text: "Please enter your email and password or log in with social media",
                                          foregroundColor: .gray1)
                        
                        Spacer().frame(height: 25)
                        
                        InputLabel(text: "Email")
                        PrimaryInputWithoutLabel(placeholder: "email address", text: $emailAddress)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Password")
                        PrimaryPasswordInputWithoutLabel(placeholder: "password", text: $password)
                        
                        Spacer().frame(height: 15)
                        
                        HStack {
                            Spacer()
                            Text("Forgot Password?")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.deepSky)
                        }
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Log in", width: geo.size.width * 0.75)
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
}
