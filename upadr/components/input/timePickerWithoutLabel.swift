import SwiftUI

struct TimePickerWithoutLabel: View {
    @Binding var selectedTime: Date
    @Binding var showTimePicker: Bool
    
    var body: some View {
        HStack {
            Text(selectedTime.formatted(.dateTime.hour().minute()))
        }
        .padding()
        .frame(minWidth: 0, maxWidth: Double.infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray3, lineWidth: 1)
        )
        .onTapGesture {
            showTimePicker = true
        }
        .sheet(isPresented: $showTimePicker) {
            VStack {
                Spacer()
                
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .padding()
                    .labelsHidden()
                
                Spacer()
                
                SolidButton(text: "Done", width: 250, onPress: {
                    showTimePicker = false
                })
            }
            .padding()
        }
    }
}


#Preview {
    TimePickerWithoutLabel(selectedTime: .constant(Date()), showTimePicker: .constant(false))
}
