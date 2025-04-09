import SwiftUI

struct ChooseProcedureScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var chooseProcedureViewModel: ChooseProcedureViewModel
    
    func fetchAllProcedures() async {
        await chooseProcedureViewModel.fetchAllProcedures()
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
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Spacer().frame(height: 25)
                            
                            Heading(text: "Welcome to upadr!")
                            
                            Spacer().frame(height: 13)
                            
                            SubHeading(text: "We’re here to get you ready for your procedure and make sure you have everything you need.",
                                       foregroundColor: .gray4)
                            
                            Spacer().frame(height: 15)
                            
                            SubHeading(text: "Let’s start with determining what procedure you",
                                       foregroundColor: .black)
                            
                            Spacer().frame(height: 20)
                        }
                        .padding(.horizontal, 25)
                        .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                        
                        if chooseProcedureViewModel.isFetchingAllProcedures {
                            ProgressView()
                        } else if (chooseProcedureViewModel.isError ||
                                   (chooseProcedureViewModel.isSuccess &&
                                    (chooseProcedureViewModel.allProceduresResponseData?.procedures == nil ||
                                     (chooseProcedureViewModel.allProceduresResponseData?.procedures != nil &&
                                      (chooseProcedureViewModel.allProceduresResponseData?.procedures?.count)! <= 0)))) {
                            Text("No procedure found")
                                .font(.subheadline)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(chooseProcedureViewModel.allProceduresResponseData?.procedures ?? []) { procedure in
                                    Text(procedure.title ?? "")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(chooseProcedureViewModel.selectedProcedure == procedure.id ? .white : .deepBlue)
                                        .padding()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(chooseProcedureViewModel.selectedProcedure == procedure.id ? .deepBlue : .white)
                                        )
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.deepBlue, lineWidth: 2))
                                        .padding(.horizontal, 25)
                                        .onTapGesture {
                                            chooseProcedureViewModel.selectedProcedure = procedure.id ?? ""
                                        }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("My Procedures")
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
                        appViewModel.selectedAppStack = .procedureStack
                        appViewModel.procedureScreenFromChooseProcedureScreen = true
                    }
                    
                    HStack {
                        Spacer()
                        
                        SolidButton(text: "Next",
                                    width: geo.size.width * 0.5,
                                    onPress: {
                            appViewModel.chooseProcedureStackNavigationPath.append(ChooseProcedureStackScreens.chooseDateAndTime)
                        },
                                    isDisabled: chooseProcedureViewModel.selectedProcedure == nil)
                    }
                    .padding(.horizontal, 25)
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
        .task {
            await fetchAllProcedures()
        }
    }
}

#Preview {
    ChooseProcedureScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ChooseProcedureViewModel())
}
