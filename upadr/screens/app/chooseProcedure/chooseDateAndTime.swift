import SwiftUI

struct ChooseDateAndTimeScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var chooseProcedureViewModel: ChooseProcedureViewModel
    @EnvironmentObject var procedureViewModel: ProcedureViewModel
    
    @State var showDatePicker: Bool = false
    @State var showTimePicker: Bool = false
    
    func createProcedure() async {
        let dateTime = combineDateAndTime(date: chooseProcedureViewModel.selectedDate,
                                          time: chooseProcedureViewModel.selectedTime)!
        
        await procedureViewModel.createProcedure(createProcedureRequestModel:
                                                    CreateProcedureRequestModel(
                                                        dateTime: dateTime,
                                                        procedureId: chooseProcedureViewModel.selectedProcedure!))
        
        if(procedureViewModel.isSuccessWhileCreatingProcedure) {
            procedureViewModel.updateSelectedProcedureToGetDetails(procedure: procedureViewModel.createProcedureResponseData?.userProcedure ?? nil)
            appViewModel.selectedAppStack = .procedureStack
            appViewModel.procedureStackNavigationPath.append(ProcedureStackScreens.procedureAllSteps)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                DrawerHeaderWithNotificationWithoutLogo()
                
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
                        DatePickerWithoutLabel(selectedDate: $chooseProcedureViewModel.selectedDate, showDatePicker: $showDatePicker)
                        
                        Spacer().frame(height: 20)
                        
                        InputLabel(text: "Time")
                        TimePickerWithoutLabel(selectedTime: $chooseProcedureViewModel.selectedTime, showTimePicker: $showTimePicker)
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            BorderedButton(text: "Back",
                                           foregroundColor: .deepSky,
                                           width: geo.size.width * 0.35,
                                           onPress: {
                                appViewModel.chooseProcedureStackNavigationPath.removeLast()
                            })
                            
                            Spacer()
                            
                            SolidButton(text: "Next",
                                        width: geo.size.width * 0.45,
                                        onPress: {
                                Task {
                                    await createProcedure()
                                }
                            },
                                        isLoading: procedureViewModel.isCreatingProcedure)
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
        .navigationBarBackButtonHidden()
        .alert(procedureViewModel.createProcedureErrorData?.message ?? "Something went wrong",
               isPresented: $procedureViewModel.isErrorWhileCreatingProcedure) {
            Button {
            } label: {
                Text("Okay")
            }
        }
    }
}

#Preview {
    ChooseDateAndTimeScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ChooseProcedureViewModel())
        .environmentObject(ProcedureViewModel())
}
