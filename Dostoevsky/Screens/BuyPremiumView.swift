import SwiftUI

struct BuyPremiumView: View {
    @EnvironmentObject var viewModel: AppState
    var body: some View {
        VStack {
            Spacer()
            Text("Premium upgrade")
                .font(.largeTitle)
                .padding()
            VStack(alignment: .leading, spacing: 10) {
                Label("Unlocks all the places from the Dostoevskys Crime and Punishment", systemImage: "checkmark")
                Label("Unlocks all the places from the Dostoevskys Humiliated and Insulted", systemImage: "checkmark")
                Label("Lets you save favourite locations, so you can look them up on the map", systemImage: "checkmark")
            }
            Spacer()
            HStack(spacing: 2) {
                Text("Unlock all features for: ")
                if let offerPrice = viewModel.offerPrice {
                    Text(offerPrice)
                        .strikethrough()
                }
                
                Text(viewModel.productPrice)
            }
            
            Button {
                Task {
                    try? await viewModel.purchasePremium()
                }
            } label: {
                ZStack {
                    Capsule(style: .continuous)
                        .foregroundColor(.blue)
                    Text("Upgrade now")
                }
                .frame(width: 200, height: 50)
            }

        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
}

struct BuyPremiumView_Previews: PreviewProvider {
    static var previews: some View {
        BuyPremiumView().environmentObject(AppState())
    }
}
