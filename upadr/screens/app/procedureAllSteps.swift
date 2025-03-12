import SwiftUI

struct ProcedureAllStepsScreen: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 10)
                        
                        Heading(text: "Great! Here’s an overview on what your prep process for Procedure Name will look like.")
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: "But don’t worry! We will send you notification when these things need to get done so you don’t have to remember it all.",
                                   foregroundColor: .gray3)
                        
                        Spacer().frame(height: 15)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Allow Notifications", width: geo.size.width * 0.75)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 25)
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
                }
                
                VStack {
                    SolidButton(text: "FAQ’s and Tips", width: geo.size.width * 0.75)
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
            }
        }
    }
}


#Preview {
    ProcedureAllStepsScreen()
}
