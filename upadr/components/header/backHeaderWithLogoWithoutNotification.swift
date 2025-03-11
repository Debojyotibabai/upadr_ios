import SwiftUI

struct BackHeaderWithLogoWithoutNotification: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .fontWeight(.medium)
                .foregroundStyle(.deepBlue)
            
            Spacer()
            
            Image(.logoWithName)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Spacer()
        }
        .padding()
        .background(.lightSky)
    }
}


#Preview {
    BackHeaderWithLogoWithoutNotification()
}
