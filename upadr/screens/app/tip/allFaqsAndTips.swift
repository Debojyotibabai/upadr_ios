import SwiftUI

struct AllFaqsAndTipsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var chooseProcedureViewModel: ChooseProcedureViewModel
    @EnvironmentObject var tipViewModel: TipViewModel
    
    func getAllProcedures() async {
        await chooseProcedureViewModel.fetchAllProcedures()
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                Heading(text: "FAQs and Tips")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                if(chooseProcedureViewModel.isFetchingAllProcedures) {
                    ProgressView()
                        .frame(minWidth: 0,
                               maxWidth: geo.size.width,
                               minHeight: 0,
                               maxHeight: geo.size.height,
                               alignment: .center)
                } else if (chooseProcedureViewModel.isError ||
                           (chooseProcedureViewModel.isSuccess &&
                            (chooseProcedureViewModel.allProceduresResponseData?.procedures == nil ||
                             (chooseProcedureViewModel.allProceduresResponseData?.procedures != nil &&
                              (chooseProcedureViewModel.allProceduresResponseData?.procedures?.count)! <= 0)))) {
                    Text("No procedure found")
                        .font(.subheadline)
                        .frame(minWidth: 0,
                               maxWidth: geo.size.width,
                               minHeight: 0,
                               maxHeight: geo.size.height,
                               alignment: .center)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(chooseProcedureViewModel.allProceduresResponseData?.procedures ?? []) { procedure in
                                Text(procedure.title ?? "")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.deepBlue)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .center)
                                    .background(.gray5)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                    .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
                                    .padding(.horizontal, 25)
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        tipViewModel.selectedProcedureForGetTips = procedure
                                        appViewModel.tipStackNavigationPath.append(TipStackScreens.particularProcedureFaqsAndTips)
                                    }
                            }
                        }
                    }
                }
            }
        }
        .task {
            await getAllProcedures()
        }
    }
}


#Preview {
    AllFaqsAndTipsScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ChooseProcedureViewModel())
        .environmentObject(TipViewModel())
}
