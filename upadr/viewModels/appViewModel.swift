import SwiftUI

class AppViewModel: ObservableObject {
    @Published var chooseProcedureStackNavigationPath: NavigationPath = NavigationPath()
    @Published var procedureStackNavigationPath: NavigationPath = NavigationPath()
    @Published var tipStackNavigationPath: NavigationPath = NavigationPath()
    @Published var surveyStackNavigationPath: NavigationPath = NavigationPath()
    @Published var settingsStackNavigationPath: NavigationPath = NavigationPath()
    @Published var notificationStackNavigationPath: NavigationPath = NavigationPath()
    
    @Published var selectedAppStack: AppStacks = .procedureStack
    @Published var selectedPreviousAppStack: AppStacks = .procedureStack
    
    @Published var isSidebarDrawerOpened: Bool = false
    
    @Published var procedureScreenFromChooseProcedureScreen: Bool = false
    
    @Published var isLogoutModalVisible: Bool = false
    
    func openSidebarDrawer() {
        isSidebarDrawerOpened = true
    }
    
    func closeSidebarDrawer() {
        isSidebarDrawerOpened = false
    }
    
    func resetAppViewModel() {
        chooseProcedureStackNavigationPath = NavigationPath()
        procedureStackNavigationPath = NavigationPath()
        tipStackNavigationPath = NavigationPath()
        surveyStackNavigationPath = NavigationPath()
        settingsStackNavigationPath = NavigationPath()
        notificationStackNavigationPath = NavigationPath()
        
        selectedAppStack = .procedureStack
        selectedPreviousAppStack = .procedureStack
        
        isSidebarDrawerOpened = false
        procedureScreenFromChooseProcedureScreen = false
        isLogoutModalVisible = false
    }
}

enum AppStacks: Int, CaseIterable {
    case chooseProcedureStack, procedureStack, tipStack, surveyStack, settingsStack, notificationStack
    
    var title: String {
        switch self {
        case .chooseProcedureStack:
            return ""
        case .procedureStack:
            return "My Procedures"
        case .tipStack:
            return "Tips"
        case .surveyStack:
            return "Surveys"
        case .settingsStack:
            return "Settings"
        case .notificationStack:
            return "Notifications"
        }
    }
    
    var icon: String {
        switch self {
        case .chooseProcedureStack:
            return ""
        case .procedureStack:
            return "stethoscope"
        case .tipStack:
            return "lightbulb.fill"
        case .surveyStack:
            return "text.page.fill"
        case .settingsStack:
            return "gearshape.fill"
        case .notificationStack:
            return "bell.fill"
        }
    }
}

enum ChooseProcedureStackScreens {
    case chooseDateAndTime
}

enum ProcedureStackScreens {
    case editProcedure, procedureAllSteps, procedureParticularStepDetails
}

enum TipStackScreens {
    case particularProcedureFaqsAndTips
}

enum SurveyStackScreens {}

enum SettingsStackScreens {}

enum NotificationStackScreens {}
