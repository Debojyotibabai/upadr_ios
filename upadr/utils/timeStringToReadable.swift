import SwiftUI

func timeStringToReadable(_ time: String) -> String {
    let components = time.split(separator: ":").map { Int($0) ?? 0 }
    
    guard components.count == 3 else { return "Invalid time format" }
    
    var hours = components[0]
    var minutes = components[1]
    var seconds = components[2]
    
    // Normalize values
    hours += minutes / 60
    minutes = minutes % 60
    minutes += seconds / 60
    seconds = seconds % 60
    
    let totalMinutes = hours * 60 + minutes
    let totalHours = totalMinutes / 60
    let totalDays = totalHours / 24
    
    if totalDays > 0 {
        return totalDays == 1 ? "1 day" : "\(totalDays) days"
    } else if totalHours > 0 {
        return totalHours == 1 ? "1 hour" : "\(totalHours) hours"
    } else if totalMinutes > 0 {
        return totalMinutes == 1 ? "1 minute" : "\(totalMinutes) minutes"
    } else {
        return seconds == 1 ? "1 second" : "\(seconds) seconds"
    }
}
