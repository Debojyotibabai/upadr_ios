import SwiftUI

struct SurveyScreen: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                VStack(alignment: .leading) {
                    Heading(text: "Survey")
                    
                    Spacer()
                    
                    VStack {
                        SubHeading(text: "Coming soon...", foregroundColor: .gray3)
                    }
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
            }
        }
    }
}


#Preview {
    SurveyScreen()
}
