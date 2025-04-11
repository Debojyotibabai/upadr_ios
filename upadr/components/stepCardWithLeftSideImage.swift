import SwiftUI

struct StepCardWithLeftSideImage: View {
    var title: String
    var subTitle: String
    var description: String
    var image: String
    var seeMoreOnPress: () -> Void = {}
    
    var slicedDescription: String {
        let end = min(description.count, 100)
        let endIndex = description.index(description.startIndex, offsetBy: end)
        return String(description[..<endIndex])
    }
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .padding(.leading, 25)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .offset(x: -40)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                        .offset(x: -40)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .trailing) {
                Heading(text: title)
                    .multilineTextAlignment(.trailing)
                
                Spacer().frame(height: 5)
                
                Text(subTitle)
                    .font(.system(size: 18))
                    .foregroundColor(.gray2)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                
                Spacer().frame(height: 10)
                
                Text(slicedDescription)
                    .font(.system(size: 18))
                    .foregroundColor(.gray3)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                
                Spacer().frame(height: 10)
                
                if(description.count > 100) {
                    Text("See More Details")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.deepSky)
                        .multilineTextAlignment(.trailing)
                        .onTapGesture {
                            seeMoreOnPress()
                        }
                }
            }
            .padding(.trailing, 25)
            .frame(minWidth: 0, maxWidth: Double.infinity, alignment: .trailing)
        }
        .frame(minWidth: 0, maxWidth: Double.infinity)
        .padding(.vertical, 10)
    }
}
