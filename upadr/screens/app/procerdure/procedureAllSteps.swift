import SwiftUI

struct ProcedureAllStepsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var procedureViewModel: ProcedureViewModel
    
    func getParticluarProcedureDetailsData() async {
        guard let userProcedureId = procedureViewModel.selectedProcedureToGetDetails?.userProcedureID else {
            return
        }
        
        await procedureViewModel.fetchParticularProcedureDetails(userProcedureId: userProcedureId)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoAndNotification(onBack: {
                    appViewModel.procedureStackNavigationPath.removeLast()
                })
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 10)
                        
                        HStack(alignment: .top) {
                            Heading(text: "Great! Here’s an overview on what your prep process for \(procedureViewModel.selectedProcedureToGetDetails?.procedure?.title ?? "this procedure") will look like.")
                            
                            Spacer()
                            
                            VStack {
                                Spacer().frame(height: 10)
                                
                                Menu {
                                    Button {
                                        procedureViewModel.updateSelectedProcedureDateTimeToEdit(dateTime: procedureViewModel.particularProcedureDetailsResponseData?.userProcedures.dateTime)
                                        
                                        appViewModel.procedureStackNavigationPath.append(ProcedureStackScreens.editProcedure)
                                    } label: {
                                        SubHeading(text: "Edit Procedure")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        SubHeading(text: "Cancel Procedure")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.gray4)
                                }
                            }
                        }
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: "But don’t worry! We will send you notification when these things need to get done so you don’t have to remember it all.",
                                   foregroundColor: .gray3)
                        
                        Spacer().frame(height: 15)
                        
                        HStack {
                            Spacer()
                            SolidButton(text: "Allow Notifications",
                                        width: geo.size.width * 0.75)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 25)
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
                    
                    Spacer().frame(height: 15)
                    
                    if(procedureViewModel.isFetchingParticularProcedureDetails) {
                        ProgressView()
                            .padding(.top, 50)
                    } else if(procedureViewModel.isErrorWhileFetchingParticularProcedureDetails ||
                              (procedureViewModel.isSuccessWhileFetchingParticularProcedureDetails &&
                               (procedureViewModel.particularProcedureDetailsResponseData == nil ||
                                (procedureViewModel.particularProcedureDetailsResponseData != nil &&
                                 procedureViewModel.particularProcedureDetailsResponseData?.userProcedures.procedure.steps != nil &&
                                 (procedureViewModel.particularProcedureDetailsResponseData?.userProcedures.procedure.steps?.count)! <= 0)))) {
                        Text("No step found")
                            .font(.subheadline)
                            .padding(.top, 50)
                    } else {
                        LazyVStack {
                            ForEach(Array((procedureViewModel.particularProcedureDetailsResponseData?.userProcedures.procedure.steps ?? []).enumerated()), id: \.offset) { index, item in
                                if(index % 2 == 0) {
                                    StepCardWithRightSideImage(
                                        title: "Step \(index + 1)",
                                        subTitle: (item.isBeforeProcedure)! ?
                                        "\(timeStringToReadable((item.when)!)) before procedure" :
                                            "\(timeStringToReadable((item.when)!)) after procedure",
                                        description: (item.description)!,
                                        image: (item.procedureStepImageURL)!,
                                        seeMoreOnPress: {
                                            procedureViewModel.updateSelectedStepOfParticularProcedure(step: item, stepTitle: "Step \(index + 1)")
                                            appViewModel.procedureStackNavigationPath.append(ProcedureStackScreens.procedureParticularStepDetails)
                                        }
                                    )
                                } else {
                                    StepCardWithLeftSideImage(
                                        title: "Step \(index + 1)",
                                        subTitle: (item.isBeforeProcedure)! ?
                                        "\(timeStringToReadable((item.when)!)) before procedure" :
                                            "\(timeStringToReadable((item.when)!)) after procedure",
                                        description: (item.description)!,
                                        image: (item.procedureStepImageURL)!,
                                        seeMoreOnPress: {
                                            procedureViewModel.updateSelectedStepOfParticularProcedure(step: item, stepTitle: "Step \(index + 1)")
                                            appViewModel.procedureStackNavigationPath.append(ProcedureStackScreens.procedureParticularStepDetails)
                                        }
                                    )
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 15)
                }
                
                VStack {
                    SolidButton(text: "FAQ’s and Tips", width: geo.size.width * 0.75, onPress: {
                        appViewModel.selectedAppStack = .tipStack
                    })
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
            }
        }
        .navigationBarBackButtonHidden()
        .task {
            await getParticluarProcedureDetailsData()
        }
    }
}

#Preview {
    ProcedureAllStepsScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ProcedureViewModel())
}
