import SwiftUI

struct NotificationScreen: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoWithoutNotification(appViewModel: appViewModel)
                
                Heading(text: "Notifications")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0..<5) { index in
                            HStack(alignment: .top, spacing: 10) {
                                Image(.logoWithoutName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55, height: 55)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("upadr")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.gray3)
                                    
                                    SubHeading(text: "It’s 1 day until your procedure! It’s time to lorem ipsum dolor sit amet dolor...", foregroundColor: .gray4)
                                }
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
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    NotificationScreen()
        .environmentObject(AppViewModel())
}
