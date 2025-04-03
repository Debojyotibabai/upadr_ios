import SwiftUI

struct ProcedureStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @StateObject var myProcedureViewModel: MyProcedureViewModel = MyProcedureViewModel()
    
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
        .environmentObject(myProcedureViewModel)
    }
}

#Preview {
    ProcedureStack()
        .environmentObject(AppViewModel())
}
