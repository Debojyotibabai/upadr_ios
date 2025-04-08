import SwiftUI

struct ChooseProcedureStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @StateObject var chooseProcedureViewModel: ChooseProcedureViewModel = ChooseProcedureViewModel()
    @StateObject var procedureViewModel: ProcedureViewModel = ProcedureViewModel()
    
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
        .environmentObject(procedureViewModel)
    }
}

#Preview {
    ChooseProcedureStack()
        .environmentObject(AppViewModel())
}
