import SwiftUI

struct Heading: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 25, weight: .semibold))
            .foregroundColor(.black)
    }
}

#Preview {
    Heading(text: "Primary heading")
}
