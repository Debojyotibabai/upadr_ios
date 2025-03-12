import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(.logoWithName)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                
                Spacer().frame(height: 100)
                
                SolidButton(text: "Sign Up", width: geo.size.width * 0.8)
                
                Spacer().frame(height: 15)
                
                SolidButton(text: "Login", width: geo.size.width * 0.8)
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height)
            .background(.lightSky)
        }
    }
}

#Preview {
    WelcomeScreen()
}
