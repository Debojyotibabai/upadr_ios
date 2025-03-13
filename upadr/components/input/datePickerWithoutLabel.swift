import SwiftUI

struct DatePickerWithoutLabel: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        HStack {
            Text(selectedDate.formatted(.dateTime.day().month().year()))
            
            Spacer()
            
            Image(systemName: "calendar")
                .foregroundColor(.deepSky)
                .font(.system(size: 20))
        }
        .padding()
        .frame(minWidth: 0, maxWidth: Double.infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray3, lineWidth: 1)
        )
        .onTapGesture {
            showDatePicker = true
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                Spacer()
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .labelsHidden()
                
                Spacer()
                
                SolidButton(text: "Done", width: 250, onPress: {
                    showDatePicker = false
                })
            }
            .padding()
        }
    }
}


#Preview {
    DatePickerWithoutLabel(selectedDate: .constant(Date()), showDatePicker: .constant(false))
}
