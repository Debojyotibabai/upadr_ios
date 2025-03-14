import SwiftUI

struct AppMainStack: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        Text("")
    }
}


#Preview {
    AppMainStack()
        .environmentObject(AuthViewModel())
        .environmentObject(AppViewModel())
}
