import SwiftUI

struct LogoutModal: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var parentGeoWidth: CGFloat
    var onLogout: () -> Void = {}
    var isLoggingout: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black.opacity(0.5))
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundStyle(.gray1)
                        .onTapGesture {
                            appViewModel.isLogoutModalVisible = false
                        }
                }
                
                Text("Log out")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray1)
                
                Spacer().frame(height: 20)
                
                Text("Are you sure you want to log out of your account? You will have to log back in later.")
                    .font(.subheadline)
                    .foregroundStyle(.gray1)
                    .lineSpacing(4)
                
                Spacer().frame(height: 30)
                
                SolidButton(text: "Log out",
                            onPress: onLogout,
                            isLoading: isLoggingout)
                
                Spacer().frame(height: 15)
                
                BorderedButton(text: "Cancel",
                               onPress: {
                    appViewModel.isLogoutModalVisible = false
                })
            }
            .padding()
            .frame(minWidth: 0, maxWidth: parentGeoWidth * 0.8)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    LogoutModal(parentGeoWidth: 400)
        .environmentObject(AppViewModel())
}
