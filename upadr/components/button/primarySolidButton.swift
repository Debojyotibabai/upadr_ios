import SwiftUI

struct PrimarySolidButton: View {
    var text: String
    var foregroundColor: Color?
    var backgroundColor: Color?
    var width: CGFloat?
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(foregroundColor ?? .white)
            .padding()
            .frame(minWidth: 0,
                   maxWidth: width ?? .infinity)
            .background(backgroundColor ?? .deepBlue)
            .clipShape(
                Capsule()
            )
    }
}

#Preview {
    PrimarySolidButton(text: "Button")
}
