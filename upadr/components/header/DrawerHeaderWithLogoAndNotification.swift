import SwiftUI

struct DrawerHeaderWithLogoAndNotification: View {
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
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
        .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
    }
}


#Preview {
    DrawerHeaderWithLogoAndNotification()
}
