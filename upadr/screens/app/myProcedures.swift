import SwiftUI

struct MyProceduresScreen: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                PrimaryHeading(text: "My Procedures")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    PrimarySubHeading(text: "Upcoming", foregroundColor: .gray4)
                    
                    Divider()
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0..<5) { index in
                            HStack {
                                Text("Procedure")
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
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    PrimarySubHeading(text: "Completed", foregroundColor: .gray4)
                    
                    Divider()
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0..<5) { index in
                            HStack {
                                Text("Procedure")
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
                        }
                    }
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
    MyProceduresScreen()
}
