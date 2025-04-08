import SwiftUI

struct MyProceduresScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var procedureViewModel: ProcedureViewModel
    
    @State private var upcomingProcedures: [Procedure] = []
    @State private var completedProcedures: [Procedure] = []
    
    func fetchMyAllProcedures() async {
        await procedureViewModel.fetchAllProcedures()
        
        if(procedureViewModel.isSuccessWhileFetchingAllProcedure) {
            if((procedureViewModel.allProceduresResponseData?.procedures!.count)! > 0) {
                procedureViewModel.allProceduresResponseData?.procedures!.forEach({ procedure in
                    if(procedure.status == "Active") {
                        upcomingProcedures.append(procedure)
                    } else {
                        completedProcedures.append(procedure)
                    }
                })
            } else if(!appViewModel.procedureScreenFromChooseProcedureScreen) {
                appViewModel.selectedAppStack = .chooseProcedureStack
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                Heading(text: "My Procedures")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    SubHeading(text: "Upcoming", foregroundColor: .gray4)
                    
                    Divider()
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    if(procedureViewModel.isFetchingAllProcedures) {
                        ProgressView()
                            .frame(minWidth: 0,
                                   maxWidth: geo.size.width,
                                   minHeight: 0,
                                   maxHeight: geo.size.height,
                                   alignment: .center)
                    } else {
                        LazyVStack {
                            ForEach(upcomingProcedures) { procedure in
                                HStack {
                                    Text(procedure.title!)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.gray2)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
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
                                .padding(.horizontal, 25)
                                .padding(.bottom, 10)
                                .onTapGesture {
                                    appViewModel.procedureStackNavigationPath.append(ProcedureStackScreens.procedureAllSteps)
                                }
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    SubHeading(text: "Completed", foregroundColor: .gray4)
                    
                    Divider()
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    if(procedureViewModel.isFetchingAllProcedures) {
                        ProgressView()
                            .frame(minWidth: 0,
                                   maxWidth: geo.size.width,
                                   minHeight: 0,
                                   maxHeight: geo.size.height,
                                   alignment: .center)
                    } else {
                        LazyVStack {
                            ForEach(completedProcedures) { procedure in
                                HStack {
                                    Text(procedure.title!)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.gray2)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
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
                                .padding(.horizontal, 25)
                                .padding(.bottom, 10)
                                .onTapGesture {
                                    appViewModel.procedureStackNavigationPath.append(ProcedureStackScreens.procedureAllSteps)
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    SolidButton(text: "FAQ’s and Tips", width: geo.size.width * 0.75, onPress: {
                        appViewModel.selectedAppStack = .tipStack
                    })
                    
                    Spacer().frame(height: 10)
                    
                    BorderedButton(text: "Prep For Another Procedure",
                                   foregroundColor: .deepSky,
                                   width: geo.size.width * 0.75,
                                   onPress: {
                        appViewModel.chooseProcedureStackNavigationPath = NavigationPath()
                        appViewModel.selectedAppStack = .chooseProcedureStack
                    })
                }
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
            }
        }
        .task {
            await fetchMyAllProcedures()
        }
        .onDisappear {
            upcomingProcedures.removeAll()
            completedProcedures.removeAll()
        }
    }
}

#Preview {
    MyProceduresScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ProcedureViewModel())
}
