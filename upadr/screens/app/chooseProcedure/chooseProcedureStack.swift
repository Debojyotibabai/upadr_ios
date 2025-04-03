import SwiftUI

struct ChooseProcedureStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @StateObject var chooseProcedureViewModel: ChooseProcedureViewModel = ChooseProcedureViewModel()
    
    var body: some View {
        NavigationStack(path: $appViewModel.chooseProcedureStackNavigationPath) {
            ChooseProcedureScreen()
                .navigationDestination(for: ChooseProcedureStackScreens.self) { screen in
                    switch screen {
                    case .chooseDateAndTime:
                        ChooseDateAndTimeScreen()
                    }
                }
        }
        .environmentObject(chooseProcedureViewModel)
    }
}

#Preview {
    ChooseProcedureStack()
        .environmentObject(AppViewModel())
}
