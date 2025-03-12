import SwiftUI

struct CreateNewPasswordScreen: View {
    @State var otp: [String] = Array(repeating: "", count: 6)
    @FocusState var focusedField: Int?
    
    @State var password:String = ""
    @State var confirmPassword:String = ""
    
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
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
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
                        PrimaryHeading(text: "Create New Password")
                        
                        Spacer().frame(height: 13)
                        
                        PrimarySubHeading(text: "Please enter the 6 digit code sent to email@example.com",
                                          foregroundColor: .gray1)
                    }
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    
                    Spacer().frame(height: 80)
                    
                    PrimaryOtpInputWithoutLabel(otp: $otp,
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
                    }
                    
                    Spacer().frame(height: 40)
                    
                    VStack(alignment: .leading) {
                        PrimarySubHeading(text: "Your new password must be different from your previously used password",
                                          foregroundColor: .gray1)
                        
                        Spacer().frame(height: 30)
                        
                        InputLabel(text: "Password")
                        PrimaryPasswordInputWithoutLabel(placeholder: "password", text: $password)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Confirm Password")
                        PrimaryPasswordInputWithoutLabel(placeholder: "confirm password", text: $confirmPassword)
                    }
                    .frame(minWidth: 0,
                           maxWidth: geo.size.width)
                    
                    Spacer().frame(height: 50)
                    
                    SolidButton(text: "Confirm", width: geo.size.width * 0.75)
                    
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
        }
    }
}

#Preview {
    CreateNewPasswordScreen()
}
