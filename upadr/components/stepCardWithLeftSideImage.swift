import SwiftUI

struct StepCardWithLeftSideImage: View {
    var seeMoreOnPress: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 0) {
            Circle()
                .foregroundStyle(Color(.systemGray5))
                .offset(x: -40)
            
            VStack(alignment: .trailing) {
                Heading(text: "Step 1")
                    .multilineTextAlignment(.trailing)
                
                Spacer().frame(height: 5)
                
                SubHeading(text: "3 days before procedure", foregroundColor: .gray2)
                    .multilineTextAlignment(.trailing)
                
                Spacer().frame(height: 10)
                
                SubHeading(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
                           foregroundColor: .gray3)
                .multilineTextAlignment(.trailing)
                
                Spacer().frame(height: 10)
                
                Text("See More Details")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.deepSky)
                    .multilineTextAlignment(.trailing)
                    .onTapGesture {
                        seeMoreOnPress()
                    }
            }
            .padding(.trailing, 25)
            .frame(minWidth: 0, maxWidth: Double.infinity, alignment: .trailing)
        }
        .frame(minWidth: 0, maxWidth: Double.infinity)
        .padding(.vertical, 10)
    }
}


#Preview {
    StepCardWithLeftSideImage()
}
