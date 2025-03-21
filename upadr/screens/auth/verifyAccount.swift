import SwiftUI

struct VerifyAccountScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var signupViewModel: SignupViewModel
    
    @State var otp: [String] = Array(repeating: "", count: 6)
    @FocusState var focusedField: Int?
    
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
        await signupViewModel.signupWithEmailAndPassword(signupWithEmailPasswordModel: signupViewModel.lastSignedupUserData!)
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
                    Heading(text: "Verify Your Email")
                    
                    Spacer().frame(height: 13)
                    
                    SubHeading(text: "Please enter the 6 digit code sent to \(signupViewModel.lastSignedupUserData?.emailAddress ?? "your email")",
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
                        .disabled(signupViewModel.isSignupLoading)
                        .onTapGesture {
                            Task {
                                await resendOtp()
                            }
                        }
                }
                
                Spacer()
                
                SolidButton(text: "Verify", width: geo.size.width * 0.75, onPress: {
                    authViewModel.authNavigationPath = NavigationPath()
                    authViewModel.authNavigationPath.append(AuthScreens.login)
                })
                
                Spacer().frame(height: 25)
                
                Text("Change Email?")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.deepSky)
                    .onTapGesture {
                        authViewModel.authNavigationPath.removeLast()
                    }
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height,
                   alignment: .topLeading)
            .padding(25)
        }
        .alert("OTP has been sent successfully!",
               isPresented: $signupViewModel.isSuccess) {
            Button {
                signupViewModel.resetSignupViewModel()
            } label: {
                Text("Okay")
            }
        }
               .alert("OTP has been sent successfully!",
                      isPresented: $signupViewModel.isError) {
                   Button {
                       signupViewModel.resetSignupViewModel()
                   } label: {
                       Text("Okay")
                   }
               }
    }
}

#Preview {
    VerifyAccountScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(SignupViewModel())
}
