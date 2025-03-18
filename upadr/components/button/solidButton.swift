import SwiftUI

struct SolidButton: View {
    var text: String
    var foregroundColor: Color?
    var backgroundColor: Color?
    var width: CGFloat?
    var onPress: () -> Void = {}
    var isDisabled: Bool = false
    var isLoading: Bool = false
    
    var body: some View {
        Button {
            isLoading || isDisabled ? nil : onPress()
        } label: {
            Text(isLoading ? "Loading..." : text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(foregroundColor ?? .white)
                .padding()
                .frame(minWidth: 0,
                       maxWidth: width ?? .infinity)
                .background(isDisabled ? .gray3 : backgroundColor ?? .deepBlue)
                .clipShape(
                    Capsule()
                )
        }
    }
}

#Preview {
    SolidButton(text: "Button")
}
