import SwiftUI

struct BackHeaderWithLogoWithoutNotification: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var onBack: () -> Void = {}
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .fontWeight(.medium)
                .foregroundStyle(.deepBlue)
                .onTapGesture {
                    onBack()
                }
            
            Spacer()
            
            Image(.logoWithName)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Spacer()
        }
        .padding()
        .background(.lightSky)
        .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
    }
}


#Preview {
    BackHeaderWithLogoWithoutNotification()
        .environmentObject(AppViewModel())
}
