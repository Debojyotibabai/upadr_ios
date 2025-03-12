import SwiftUI

struct ChooseProcedureScreen: View {
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
                            
                            PrimaryHeading(text: "Welcome to upadr!")
                            
                            Spacer().frame(height: 13)
                            
                            PrimarySubHeading(text: "We’re here to get you ready for your procedure and make sure you have everything you need.",
                                              foregroundColor: .gray4)
                            
                            Spacer().frame(height: 15)
                            
                            PrimarySubHeading(text: "Let’s start with determining what procedure you",
                                              foregroundColor: .black)
                            
                            Spacer().frame(height: 20)
                        }
                        .padding(.horizontal, 25)
                        .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(0..<10) { index in
                                Text("Procedure #\(index + 1)")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(selectedProcedure == index ? .white : .deepBlue)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: geo.size.width)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedProcedure == index ? .deepBlue : .white)
                                    )
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.deepBlue, lineWidth: 2))
                                    .onTapGesture {
                                        selectedProcedure = index
                                    }
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    
                    HStack {
                        Text("My Procedures")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.gray2)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.gray4)
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    .background(.gray5)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 10)
                    
                    HStack {
                        Spacer()
                        
                        SolidButton(text: "Next", width: geo.size.width * 0.5)
                    }
                    .padding(.horizontal, 25)
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
    ChooseProcedureScreen()
}
