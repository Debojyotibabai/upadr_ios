import Foundation

func combineDateAndTime(date: Date, time: Date) -> String? {
    let calendar = Calendar.current
    
    // Extract date components
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
    
    // Combine date and time components
    var combinedComponents = DateComponents()
    combinedComponents.year = dateComponents.year
    combinedComponents.month = dateComponents.month
    combinedComponents.day = dateComponents.day
    combinedComponents.hour = timeComponents.hour
    combinedComponents.minute = timeComponents.minute
    combinedComponents.second = timeComponents.second
    
    // Create combined Date
    if let combinedDate = calendar.date(from: combinedComponents) {
        // Format as ISO8601 in UTC (Z)
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: combinedDate)
    }
    
    return nil
}
