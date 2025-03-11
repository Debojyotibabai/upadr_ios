import SwiftUI

struct PrimaryOtpInputWithoutLabel: View {
    @Binding var otp: [String]
    @FocusState.Binding var focusedField: Int?
    var handleInputChange: (String, Int) -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: $otp[index])
                    .keyboardType(.numberPad)
                    .frame(width: 50, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray3, lineWidth: 1.5)
                    )
                    .multilineTextAlignment(.center)
                    .focused($focusedField, equals: index)
                    .onChange(of: otp[index]) { oldValue, newValue in
                        handleInputChange(newValue, index)
                    }
            }
        }
    }
}
