import SwiftUI

struct AllFaqsAndTipsScreen: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                DrawerHeaderWithLogoAndNotification()
                
                PrimaryHeading(text: "FAQs and Tips")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0..<5) { index in
                            Text("Procedure #\(index + 1)")
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
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    AllFaqsAndTipsScreen()
}
