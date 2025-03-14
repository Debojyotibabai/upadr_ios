import SwiftUI

struct ChooseProcedureStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack(path: $appViewModel.chooseProcedureStackNavigationPath) {
            ChooseProcedureScreen()
        }
        .navigationDestination(for: ChooseProcedureStackScreens.self) { screen in
            switch screen {
            case .chooseDateAndTime:
                ChooseDateAndTimeScreen()
            }
        }
    }
}

#Preview {
    ChooseProcedureStack()
        .environmentObject(AppViewModel())
}
