import SwiftUI

struct ProcedureStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack(path: $appViewModel.procedureStackNavigationPath) {
            MyProceduresScreen()
        }
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
}

#Preview {
    ProcedureStack()
        .environmentObject(AppViewModel())
}
