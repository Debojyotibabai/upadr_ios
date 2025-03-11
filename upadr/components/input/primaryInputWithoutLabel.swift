import SwiftUI

struct PrimaryInputWithoutLabel: View {
    var placeholder:String
    @Binding var text: String
    
    var body: some View {
        TextField("",
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
    PrimaryInputWithoutLabel(placeholder: "Input", text: .constant(""))
}
