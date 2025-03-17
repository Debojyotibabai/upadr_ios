import SwiftUI

struct TipStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
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
    }
}

#Preview {
    TipStack()
        .environmentObject(AppViewModel())
}
