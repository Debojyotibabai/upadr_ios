import SwiftUI

struct SubHeading: View {
    var text: String
    var foregroundColor: Color?
    
    var body: some View {
        Text(text)
            .font(.system(size: 18))
            .foregroundColor(foregroundColor ?? .black)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SubHeading(text: "Primary subheading")
}
