import SwiftUI

struct DrawerHeaderWithNotificationWithoutLogo: View {
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .fontWeight(.medium)
                .foregroundStyle(.deepBlue)
            
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
    DrawerHeaderWithNotificationWithoutLogo()
}
