import SwiftUI

class AppViewModel: ObservableObject {
    
}

enum AppScreens: Int, CaseIterable {
    case procedures, tips, surveys, settings, notifications
    
    var title:String {
        switch self {
        case .procedures:
            return "My Procedures"
        case .tips:
            return "Tips"
        case .surveys:
            return "Surveys"
        case .settings:
            return "Settings"
        case .notifications:
            return "Notifications"
        }
    }
    
    var icon:String {
        switch self {
        case .procedures:
            return "stethoscope"
        case .tips:
            return "lightbulb.fill"
        case .surveys:
            return "text.page.fill"
        case .settings:
            return "gearshape.fill"
        case .notifications:
            return "bell.fill"
        }
    }
}
