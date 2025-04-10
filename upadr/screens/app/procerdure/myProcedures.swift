import SwiftUI

struct MyProceduresScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var procedureViewModel: ProcedureViewModel
    
    func fetchMyAllProcedures() async {
        await procedureViewModel.fetchAllProcedures()
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
                    } else if(procedureViewModel.isErrorWhileFetchingAllProcedure ||
                              (procedureViewModel.isSuccessWhileFetchingAllProcedure &&
                               (procedureViewModel.allProceduresResponseData?.upcomingUserProcedures == nil ||
                                (procedureViewModel.allProceduresResponseData?.upcomingUserProcedures != nil &&
                                 (procedureViewModel.allProceduresResponseData?.upcomingUserProcedures?.count)! <= 0)))) {
                        Text("No upcoming procedures found")
                            .font(.subheadline)
                            .padding(.horizontal, 25)
                            .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
                    } else {
                        LazyVStack {
                            ForEach(procedureViewModel.allProceduresResponseData?.upcomingUserProcedures ?? []) { procedure in
                                HStack {
                                    Text(procedure.procedure?.title ?? "")
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
                                    procedureViewModel.updateSelectedProcedureToGetDetails(procedure: procedure)
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
                    } else if(procedureViewModel.isErrorWhileFetchingAllProcedure ||
                              (procedureViewModel.isSuccessWhileFetchingAllProcedure &&
                               (procedureViewModel.allProceduresResponseData?.completedUserProcedures == nil ||
                                (procedureViewModel.allProceduresResponseData?.completedUserProcedures != nil &&
                                 (procedureViewModel.allProceduresResponseData?.completedUserProcedures?.count)! <= 0)))) {
                        Text("No completed procedures found")
                            .font(.subheadline)
                            .padding(.horizontal, 25)
                            .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
                    } else {
                        LazyVStack {
                            ForEach(procedureViewModel.allProceduresResponseData?.completedUserProcedures ?? []) { procedure in
                                HStack {
                                    Text(procedure.procedure?.title ?? "")
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
                                    procedureViewModel.updateSelectedProcedureToGetDetails(procedure: procedure)
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
    }
}

#Preview {
    MyProceduresScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ProcedureViewModel())
}
