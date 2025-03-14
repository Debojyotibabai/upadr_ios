import SwiftUI

struct EditProcedureScreen: View {
    @State var selectedDate: Date = Date()
    @State var showDatePicker: Bool = false
    
    @State var selectedTime: Date = Date()
    @State var showTimePicker: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoAndNotification()
                
                VStack(alignment: .leading) {
                    Heading(text: "Edit Your Procedure")
                    
                    Spacer().frame(height: 25)
                    
                    InputLabel(text: "Procedure name")
                    HStack {
                        Text("Procedure")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.gray2)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.gray4)
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                    .background(.gray5)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
                    
                    Spacer().frame(height: 20)
                    
                    InputLabel(text: "Date")
                    DatePickerWithoutLabel(selectedDate: $selectedDate, showDatePicker: $showDatePicker)
                    
                    Spacer().frame(height: 20)
                    
                    InputLabel(text: "Time")
                    TimePickerWithoutLabel(selectedTime: $selectedTime, showTimePicker: $showTimePicker)
                    
                    Spacer()
                    
                    VStack {
                        SolidButton(text: "Done")
                            .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                    }
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .trailing)
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
            }
        }
    }
}


#Preview {
    EditProcedureScreen()
}
