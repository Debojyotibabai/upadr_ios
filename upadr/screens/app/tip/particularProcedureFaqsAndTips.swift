import SwiftUI

struct ParticularProcedureFAqsAndTipsScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var tipViewModel: TipViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoAndNotification(onBack: {
                    appViewModel.tipStackNavigationPath.removeLast()
                })
                
                VStack(alignment: .leading) {
                    Heading(text: "FAQs and Tips")
                    
                    Spacer().frame(height: 13)
                    
                    SubHeading(text: "Here are some FAQs and Tips for a Procedure 1",
                               foregroundColor: .gray3)
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                
                if(tipViewModel.isFetchingParticularProcedureTips) {
                    ProgressView()
                        .frame(minWidth: 0,
                               maxWidth: geo.size.width,
                               minHeight: 0,
                               maxHeight: geo.size.height,
                               alignment: .center)
                } else if(tipViewModel.isErrorWhileFetchingParticularProcedureTips ||
                          (tipViewModel.isSuccessWhileFetchingParticularProcedureTips &&
                           (tipViewModel.particularProcedureTipsResponseData?.procedureTips == nil ||
                            (tipViewModel.particularProcedureTipsResponseData?.procedureTips != nil &&
                             (tipViewModel.particularProcedureTipsResponseData?.procedureTips.count)! <= 0)))) {
                    Text("No tip found")
                        .font(.subheadline)
                        .frame(minWidth: 0,
                               maxWidth: geo.size.width,
                               minHeight: 0,
                               maxHeight: geo.size.height,
                               alignment: .center)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(tipViewModel.particularProcedureTipsResponseData?.procedureTips ?? []) { tip in
                                VStack {
                                    HStack {
                                        Text(tip.question)
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.gray2)
                                        
                                        Spacer()
                                        
                                        Image(systemName: tip.isExpanded ? "chevron.up" : "chevron.down")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.gray4)
                                    }
                                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        let updatedTips: [ProcedureTip] = (tipViewModel.particularProcedureTipsResponseData?.procedureTips ?? []).map { item in
                                            if item.id == tip.id {
                                                var updatedTip = item
                                                updatedTip.isExpanded = !updatedTip.isExpanded
                                                return updatedTip
                                            } else {
                                                return item
                                            }
                                        }
                                        
                                        tipViewModel.updateParticularProcedureTipsData(data: ParticularProcedureTipsResponseModel(procedureTips: updatedTips))
                                    }
                                    
                                    tip.isExpanded ? VStack {
                                        Divider()
                                        
                                        SubHeading(text: tip.answer, foregroundColor: .gray2)
                                    }
                                    .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                                    : nil
                                }
                                .padding()
                                .frame(minWidth: 0, maxWidth: geo.size.width)
                                .background(.gray5)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                                .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 3)
                                .padding(.horizontal, 25)
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .task {
            await tipViewModel.fetchParticularProcedureTips()
        }
    }
}


#Preview {
    ParticularProcedureFAqsAndTipsScreen()
        .environmentObject(AppViewModel())
        .environmentObject(TipViewModel())
}
