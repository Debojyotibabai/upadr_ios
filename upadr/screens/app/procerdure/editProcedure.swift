import SwiftUI

struct EditProcedureScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var procedureViewModel: ProcedureViewModel
    
    @State var selectedDate: Date = Date()
    @State var showDatePicker: Bool = false
    
    @State var selectedTime: Date = Date()
    @State var showTimePicker: Bool = false
    
    func editProcedure() async {
        guard let selectedProcedureToGetDetails = procedureViewModel.selectedProcedureToGetDetails else {
            return
        }
        
        let dateTime = combineDateAndTime(date: selectedDate,
                                          time: selectedTime)
        
        let editProcedureRequestModel: CreateProcedureRequestModel = CreateProcedureRequestModel(dateTime: dateTime!,
                                                                                                 procedureId: (selectedProcedureToGetDetails.procedure?.id)!)
        
        await procedureViewModel.editParticularProcedure(editProcedureRequestModel: editProcedureRequestModel,
                                                         userProcedureId: (selectedProcedureToGetDetails.userProcedureID)!)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoAndNotification(onBack: {
                    appViewModel.procedureStackNavigationPath.removeLast()
                })
                
                VStack(alignment: .leading) {
                    Heading(text: "Edit Your Procedure")
                    
                    Spacer().frame(height: 25)
                    
                    InputLabel(text: "Procedure name")
                    HStack {
                        Text((procedureViewModel.selectedProcedureToGetDetails?.procedure?.title)!)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.gray2)
                        
                        //                        Spacer()
                        //
                        //                        Image(systemName: "chevron.down")
                        //                            .font(.system(size: 18, weight: .semibold))
                        //                            .foregroundStyle(.gray4)
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
                        SolidButton(text: "Done",
                                    width: geo.size.width * 0.5,
                                    onPress: {
                            Task {
                                await editProcedure()
                            }
                        },
                                    isLoading: procedureViewModel.isEditingProcedure)
                    }
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .trailing)
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            var dateString = procedureViewModel.selectedProcedureDateTimeToEdit ?? ""

            if !dateString.hasSuffix("Z") && !dateString.contains("+") {
                dateString += "Z"
            }

            let isoFormatter = ISO8601DateFormatter()

            if let date = isoFormatter.date(from: dateString) {
                selectedDate = date
                selectedTime = date
            }
        }

        .alert(procedureViewModel.editProcedureErrorData?.message ?? "Something went wrong",
               isPresented: $procedureViewModel.isErrorWhileEditingProcedure) {
            Button {
            } label: {
                Text("Try again")
            }
        }
               .alert(procedureViewModel.editProcedureResponseData?.message ?? "Procedure edited successfully",
                      isPresented: $procedureViewModel.isSuccessWhileEditingProcedure) {
                   Button {
                       appViewModel.procedureStackNavigationPath.removeLast()
                   } label: {
                       Text("Okay")
                   }
                   
               }
    }
}


#Preview {
    EditProcedureScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ProcedureViewModel())
}
