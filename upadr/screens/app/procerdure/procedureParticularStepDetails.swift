import SwiftUI

struct ProcedureParticularStepDetailsScreen: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 10)
                        
                        Heading(text: "Step 1")
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: "it’s 1 day until your procedure! Here’s what you need to know",
                                   foregroundColor: .gray2)
                        
                        Spacer().frame(height: 15)
                        
                        Rectangle()
                            .frame(height: 230)
                            .foregroundStyle(Color(.systemGray5))
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                   foregroundColor: .gray3)
                        
                        Spacer().frame(height: 15)
                    }
                    .padding(.horizontal, 25)
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
                }
                
                VStack {
                    SolidButton(text: "FAQ’s and Tips", width: geo.size.width * 0.75)
                    
                    Spacer().frame(height: 10)
                    
                    BorderedButton(text: "Prep For Another Procedure", foregroundColor: .deepSky, width: geo.size.width * 0.75)
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
            }
        }
    }
}


#Preview {
    ProcedureParticularStepDetailsScreen()
}
