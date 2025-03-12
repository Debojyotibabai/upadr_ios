import SwiftUI

struct PasswordInputWithoutLabel: View {
    var placeholder:String
    @Binding var text: String
    
    var body: some View {
        SecureField("",
                    text: $text,
                    prompt: Text(placeholder)
            .foregroundStyle(.gray3)
        )
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray3, lineWidth: 1)
        )
    }
}

#Preview {
    PasswordInputWithoutLabel(placeholder: "Input", text: .constant(""))
}
