import SwiftUI

struct SignupScreen: View {
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var emailAddress:String = ""
    @State var password:String = ""
    @State var confirmPassword:String = ""
    
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
                        HStack {
                            InputWithoutLabel(placeholder: "first name", text: $firstName)
                            InputWithoutLabel(placeholder: "last name", text: $lastName)
                        }
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Email")
                        InputWithoutLabel(placeholder: "email address", text: $emailAddress)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Password")
                        PasswordInputWithoutLabel(placeholder: "password", text: $password)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Confirm Password")
                        PasswordInputWithoutLabel(placeholder: "confirm password", text: $confirmPassword)
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Sign up", width: geo.size.width * 0.75)
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
    SignupScreen()
}
