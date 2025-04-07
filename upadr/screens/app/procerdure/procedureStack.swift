import SwiftUI

struct ProcedureStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @StateObject var procedureViewModel: ProcedureViewModel = ProcedureViewModel()
    
    var body: some View {
        NavigationStack(path: $appViewModel.procedureStackNavigationPath) {
            MyProceduresScreen()
                .navigationDestination(for: ProcedureStackScreens.self) { screen in
                    switch screen {
                    case .editProcedure:
                        EditProcedureScreen()
                    case .procedureAllSteps:
                        ProcedureAllStepsScreen()
                    case .procedureParticularStepDetails:
                        ProcedureParticularStepDetailsScreen()
                    }
                }
        }
        .environmentObject(procedureViewModel)
    }
}

#Preview {
    ProcedureStack()
        .environmentObject(AppViewModel())
}
