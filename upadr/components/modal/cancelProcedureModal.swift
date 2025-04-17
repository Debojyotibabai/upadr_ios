import SwiftUI

struct CancelProcedureModal: View {
    var parentGeoWidth: CGFloat
    @Binding var isCancelProcedureModalVisible: Bool
    var onCancelProcedure: () -> Void = {}
    var isCancellingProcedure: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black.opacity(0.5))
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundStyle(.gray1)
                        .onTapGesture {
                            isCancelProcedureModalVisible = false
                        }
                }
                
                Text("Cancel Procedure")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray1)
                
                Spacer().frame(height: 20)
                
                Text("Are you sure you want to cancel your procedure? This process is irreversible and you will have to re-enter your information later.")
                    .font(.subheadline)
                    .foregroundStyle(.gray1)
                    .lineSpacing(4)
                
                Spacer().frame(height: 30)
                
                SolidButton(text: "Cancel Procedure",
                            backgroundColor: .deepRed,
                            onPress: onCancelProcedure,
                            isLoading: isCancellingProcedure)
                
                Spacer().frame(height: 15)
                
                BorderedButton(text: "Cancel",
                               onPress: {
                    isCancelProcedureModalVisible = false
                })
            }
            .padding()
            .frame(minWidth: 0, maxWidth: parentGeoWidth * 0.8)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    CancelProcedureModal(parentGeoWidth: 400, isCancelProcedureModalVisible: .constant(true), isCancellingProcedure: false)
}
