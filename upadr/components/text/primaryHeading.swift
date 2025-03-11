import SwiftUI

struct PrimaryHeading: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 25, weight: .semibold))
            .foregroundColor(.black)
    }
}

#Preview {
    PrimaryHeading(text: "Primary heading")
}
