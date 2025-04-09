import SwiftUI

struct TipStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @StateObject var chooseProcedureViewModel: ChooseProcedureViewModel = ChooseProcedureViewModel()
    @StateObject var tipViewModel: TipViewModel = TipViewModel()
    
    var body: some View {
        NavigationStack(path: $appViewModel.tipStackNavigationPath) {
            AllFaqsAndTipsScreen()
                .navigationDestination(for: TipStackScreens.self) { screen in
                    switch screen {
                    case .particularProcedureFaqsAndTips:
                        ParticularProcedureFAqsAndTipsScreen()
                    }
                }
        }
        .environmentObject(chooseProcedureViewModel)
    }
}

#Preview {
    TipStack()
        .environmentObject(AppViewModel())
}
