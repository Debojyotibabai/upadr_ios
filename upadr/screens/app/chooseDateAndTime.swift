import SwiftUI

struct chooseDateAndTimeScreen: View {
    @State var selectedProcedure: Int?
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                DrawerHeaderWithNotificationWithoutLogo()
                
                VStack {
                    Image(.logoWithName)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height * 0.3)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Spacer().frame(height: 25)
                            
                            PrimaryHeading(text: "Next...")
                            
                            Spacer().frame(height: 13)
                            
                            PrimarySubHeading(text: "Let’s determine when your procedure is so we can start your prep on schedule.",
                                              foregroundColor: .gray4)
                            
                            Spacer().frame(height: 20)
                        }
                        .padding(.horizontal, 25)
                        .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    }
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height,
                       alignment: .topLeading)
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
    chooseDateAndTimeScreen()
}
