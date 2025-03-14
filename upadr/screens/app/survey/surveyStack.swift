import SwiftUI

struct SurveyStack: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack(path: $appViewModel.surveyStackNavigationPath) {
            SurveyScreen()
        }
    }
}

#Preview {
    SurveyStack()
        .environmentObject(AppViewModel())
}
