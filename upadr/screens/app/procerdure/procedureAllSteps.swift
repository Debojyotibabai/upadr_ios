import SwiftUI

struct ProcedureAllStepsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification(appViewModel: appViewModel)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 10)
                        
                        HStack(alignment: .top) {
                            Heading(text: "Great! Here’s an overview on what your prep process for Procedure Name will look like.")
                            
                            Spacer()
                            
                            VStack {
                                Spacer().frame(height: 10)
                                
                                Menu {
                                    Button {
                                        
                                    } label: {
                                        SubHeading(text: "Edit Procedure")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        SubHeading(text: "Cancel Procedure")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.gray4)
                                }
                            }
                        }
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: "But don’t worry! We will send you notification when these things need to get done so you don’t have to remember it all.",
                                   foregroundColor: .gray3)
                        
                        Spacer().frame(height: 15)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Allow Notifications",
                                        width: geo.size.width * 0.75)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 25)
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
                    
                    Spacer().frame(height: 15)
                    
                    VStack {
                        ForEach(0..<5) { index in
                            if(index % 2 == 0) {
                                StepCardWithRightSideImage()
                            } else {
                                StepCardWithLeftSideImage()
                            }
                        }
                    }
                    
                    Spacer().frame(height: 15)
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
        .environmentObject(AppViewModel())
}
