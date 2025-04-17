import SwiftUI

struct DeleteAccountModal: View {
    var parentGeoWidth: CGFloat
    @Binding var isDeleteAccountModalVisible: Bool
    var onDeleteAccount: () -> Void = {}
    var isDeletingAccount: Bool = false
    
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
                            isDeleteAccountModalVisible = false
                        }
                }
                
                Text("Delete Account")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray1)
                
                Spacer().frame(height: 20)
                
                Text("Are you sure you want to delete your account? This process is irreversible and all your data will be lost.")
                    .font(.subheadline)
                    .foregroundStyle(.gray1)
                    .lineSpacing(4)
                
                Spacer().frame(height: 30)
                
                SolidButton(text: "Delete Account",
                            backgroundColor: .deepRed,
                            onPress: onDeleteAccount,
                            isLoading: isDeletingAccount)
                
                Spacer().frame(height: 15)
                
                BorderedButton(text: "Cancel",
                               onPress: {
                    isDeleteAccountModalVisible = false
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
    DeleteAccountModal(parentGeoWidth: 400, isDeleteAccountModalVisible: .constant(true))
}
