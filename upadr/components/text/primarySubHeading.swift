import SwiftUI

struct PrimarySubHeading: View {
    var text: String
    var foregroundColor: Color?
    
    var body: some View {
        Text(text)
            .font(.system(size: 18))
            .foregroundColor(foregroundColor ?? .black)
    }
}

#Preview {
    PrimarySubHeading(text: "Primary subheading")
}
