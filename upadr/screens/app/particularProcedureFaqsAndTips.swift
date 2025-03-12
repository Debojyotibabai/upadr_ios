import SwiftUI

struct ParticularProcedureFAqsAndTipsScreen: View {
    @State var faqAndTipsData: [Bool] = [false, false, false, false, false]
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                BackHeaderWithLogoAndNotification()
                
                VStack(alignment: .leading) {
                    PrimaryHeading(text: "FAQs and Tips")
                    
                    Spacer().frame(height: 13)
                    
                    PrimarySubHeading(text: "Here are some FAQs and Tips for a Procedure 1",
                                      foregroundColor: .gray3)
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(faqAndTipsData.indices, id: \.self) { index in
                            VStack {
                                HStack {
                                    Text("What if my blood sugar levels are getting too low?")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.gray2)
                                    
                                    Spacer()
                                    
                                    Image(systemName: faqAndTipsData[index] ? "chevron.up" : "chevron.down")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.gray4)
                                }
                                .frame(minWidth: 0, maxWidth: geo.size.width, alignment: .leading)
                                .onTapGesture {
                                    faqAndTipsData[index].toggle()
                                }
                                
                                faqAndTipsData[index] ? VStack {
                                    Divider()
                                    
                                    PrimarySubHeading(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris", foregroundColor: .gray2)
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
}


#Preview {
    ParticularProcedureFAqsAndTipsScreen()
}
