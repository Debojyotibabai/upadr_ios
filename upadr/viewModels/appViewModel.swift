import SwiftUI

class AppViewModel: ObservableObject {
    
}

enum AppScreens: Int, CaseIterable {
    case procedure, tip, survey, settings, notification
    
    var title:String {
        switch self {
        case .procedure:
            return "My Procedures"
        case .tip:
            return "Tips"
        case .survey:
            return "Surveys"
        case .settings:
            return "Settings"
        case .notification:
            return "Notifications"
        }
    }
    
    var icon:String {
        switch self {
        case .procedure:
            return "stethoscope"
        case .tip:
            return "lightbulb.fill"
        case .survey:
            return "text.page.fill"
        case .settings:
            return "gearshape.fill"
        case .notification:
            return "bell.fill"
        }
    }
}
