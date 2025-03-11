import SwiftUI

struct BackHeaderWithLogoAndNotification: View {
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
            
            Image(systemName: "bell.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .fontWeight(.medium)
                .foregroundStyle(.deepBlue)
        }
        .padding()
        .background(.lightSky)
    }
}


#Preview {
    BackHeaderWithLogoAndNotification()
}
