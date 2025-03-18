import SwiftUI

struct PasswordInputWithoutLabel: View {
    var placeholder:String
    @Binding var text: String
    var errorMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
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
            
            if(text != "" && errorMessage != "") {
                SubHeading(text: errorMessage, foregroundColor: .deepRed)
            }
        }
        .frame(minWidth: 0, maxWidth: Double.infinity, alignment: .leading)
    }
}

#Preview {
    PasswordInputWithoutLabel(placeholder: "Input", text: .constant(""))
}
