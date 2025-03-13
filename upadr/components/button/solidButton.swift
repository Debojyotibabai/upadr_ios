import SwiftUI

struct SolidButton: View {
    var text: String
    var foregroundColor: Color?
    var backgroundColor: Color?
    var width: CGFloat?
    var onPress: () -> Void = {}
    
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(foregroundColor ?? .white)
            .padding()
            .frame(minWidth: 0,
                   maxWidth: width ?? .infinity)
            .background(backgroundColor ?? .deepBlue)
            .clipShape(
                Capsule()
            )
            .onTapGesture {
                onPress()
            }
    }
}

#Preview {
    SolidButton(text: "Button")
}
