import SwiftUI

struct BorderedButton: View {
    var text: String
    var foregroundColor: Color?
    var backgroundColor: Color?
    var width: CGFloat?
    var onPress: () -> Void = {}
    
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(foregroundColor ?? .deepBlue)
            .padding()
            .frame(minWidth: 0,
                   maxWidth: width ?? .infinity)
            .background(backgroundColor ?? .white)
            .clipShape(
                Capsule()
            )
            .overlay(
                Capsule()
                    .stroke(foregroundColor ?? .deepBlue, lineWidth: 2.5)
            )
            .onTapGesture {
                onPress()
            }
    }
}

#Preview {
    BorderedButton(text: "Button")
}
