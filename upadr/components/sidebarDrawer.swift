import SwiftUI

struct SidebarDrawer: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.gray2.opacity(0.3))
                .onTapGesture {
                    appViewModel.closeSidebarDrawer()
                }
            
            VStack {
                Spacer().frame(height: 20)
                
                HStack {
                    Spacer()
                    
                    Button {
                        appViewModel.closeSidebarDrawer()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                    }
                    
                    Spacer().frame(width: 30)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        ForEach(AppStacks.allCases, id: \.self.rawValue) { item in
                            Button {
                                if(item == AppStacks.notificationStack) {
                                    appViewModel.selectedPreviousAppStack = appViewModel.selectedAppStack
                                }
                                appViewModel.selectedAppStack = item
                                appViewModel.closeSidebarDrawer()
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: item.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(.white)
                                    
                                    Text(item.title)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(.white)
                                }
                                .padding()
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.white)
                            
                            Text("Log Out")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                }
            }
            .frame(width: 280)
            .background(.greySky)
        }
    }
}

#Preview {
    SidebarDrawer()
        .environmentObject(AppViewModel())
}
