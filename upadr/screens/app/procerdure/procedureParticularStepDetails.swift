import SwiftUI

struct ProcedureParticularStepDetailsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var procedureViewModel: ProcedureViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoAndNotification(onBack: {
                    appViewModel.procedureStackNavigationPath.removeLast()
                })
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 10)
                        
                        Heading(text: procedureViewModel.selectedStepTitleOfParticularProcedure ?? "Step")
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: "it’s \((procedureViewModel.selectedStepOfParticularProcedure?.isBeforeProcedure)! ? "\(timeStringToReadable((procedureViewModel.selectedStepOfParticularProcedure?.when)!)) before" : "\(timeStringToReadable((procedureViewModel.selectedStepOfParticularProcedure?.when)!)) after") your procedure! Here’s what you need to know",
                                   foregroundColor: .gray2)
                        
                        Spacer().frame(height: 15)
                        
                        AsyncImage(url: URL(string: (procedureViewModel.selectedStepOfParticularProcedure?.procedureStepImageURL)!)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(minWidth: 0, maxWidth: geo.size.width, minHeight: 230, maxHeight: 230, alignment: .center)
                        
                        Spacer().frame(height: 15)
                        
                        SubHeading(text: (procedureViewModel.selectedStepOfParticularProcedure?.description)!,
                                   foregroundColor: .gray3)
                        
                        Spacer().frame(height: 15)
                    }
                    .padding(.horizontal, 25)
                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .topLeading)
                }
                
                VStack {
                    SolidButton(text: "FAQ’s and Tips",
                                width: geo.size.width * 0.75,
                                onPress: {
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
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    ProcedureParticularStepDetailsScreen()
        .environmentObject(AppViewModel())
        .environmentObject(ProcedureViewModel())
}
