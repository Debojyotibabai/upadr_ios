import SwiftUI

struct ForgotPasswordScreen: View {
    @State var emailAddress: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .fontWeight(.medium)
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
                
                InputWithoutLabel(placeholder: "email address", text: $emailAddress)
                
                Spacer()
                
                SolidButton(text: "Send Code", width: geo.size.width * 0.75)
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height,
                   alignment: .topLeading)
            .padding(25)
        }
    }
}

#Preview {
    ForgotPasswordScreen()
}
