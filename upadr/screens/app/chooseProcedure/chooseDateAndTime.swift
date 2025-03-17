import SwiftUI

struct ChooseDateAndTimeScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State var selectedDate: Date = Date()
    @State var showDatePicker: Bool = false
    
    @State var selectedTime: Date = Date()
    @State var showTimePicker: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                DrawerHeaderWithNotificationWithoutLogo(appViewModel: appViewModel)
                
                VStack {
                    Image(.logoWithName)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: geo.size.width * 0.5)
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height * 0.3)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 25)
                        
                        Heading(text: "Next...")
                        
                        Spacer().frame(height: 13)
                        
                        SubHeading(text: "Let’s determine when your procedure is so we can start your prep on schedule.",
                                   foregroundColor: .gray4)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Date")
                        DatePickerWithoutLabel(selectedDate: $selectedDate, showDatePicker: $showDatePicker)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Time")
                        TimePickerWithoutLabel(selectedTime: $selectedTime, showTimePicker: $showTimePicker)
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            BorderedButton(text: "Back", foregroundColor: .deepSky, width: geo.size.width * 0.35)
                            
                            Spacer()
                            
                            SolidButton(text: "Next", width: geo.size.width * 0.45)
                        }
                    }
                    .padding(.horizontal, 25)
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                }
                .frame(minWidth: 0,
                       maxWidth: geo.size.width,
                       minHeight: 0,
                       maxHeight: geo.size.height,
                       alignment: .topLeading)
                .background(.white)
            }
            .frame(minWidth: 0,
                   maxWidth: geo.size.width,
                   minHeight: 0,
                   maxHeight: geo.size.height,
                   alignment: .top)
            .background(.lightSky)
        }
    }
}

#Preview {
    ChooseDateAndTimeScreen()
        .environmentObject(AppViewModel())
}
