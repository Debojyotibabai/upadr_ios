import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    let settingsOptions: [String] = ["Terms and Conditions",
                                     "Privacy Policy",
                                     "Contact Us",
                                     "Rate App",
                                     "Accessibility",
                                     "Schedule New Procedure",
                                     "Change Password"]
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                Heading(text: "Settings")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                Text("Debojyoti Ghosh")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.gray2)
                    .padding()
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    .background(.gray5)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(settingsOptions, id: \.self) { item in
                            VStack {
                                HStack {
                                    Text(item)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.gray2)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 10)
                                
                                Divider()
                            }
                            .padding(.horizontal, 25)
                        }
                    }
                }
                
                VStack {
                    SolidButton(text: "Delete Account", backgroundColor: .deepRed)
                        .frame(minWidth: 0, maxWidth: geo.size.width * 0.8)
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
            }
        }
    }
}


#Preview {
    SettingsScreen()
        .environmentObject(AppViewModel())
}
