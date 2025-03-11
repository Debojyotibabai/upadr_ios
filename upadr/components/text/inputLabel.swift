import SwiftUI

struct InputLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.gray2)
    }
}

#Preview {
    InputLabel(text: "Input Label")
}
