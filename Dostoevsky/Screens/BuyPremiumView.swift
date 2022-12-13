import SwiftUI

struct BuyPremiumView: View {
    @EnvironmentObject var viewModel: AppState
    @Environment(\.dismiss) var dismiss
    @State var alert: AlertItem?
    var body: some View {
        VStack {
            Spacer()
            Text(L10n.BuyPremium.title)
                .font(.largeTitle)
                .padding()
            VStack(alignment: .leading, spacing: 10) {
                Label(L10n.BuyPremium.feature1, systemImage: "checkmark")
                Label(L10n.BuyPremium.feature2, systemImage: "checkmark")
                Label(L10n.BuyPremium.feature3, systemImage: "checkmark")
            }
            Spacer()
            HStack(spacing: 2) {
                Text(L10n.BuyPremium.unlockAllFeatures)
                if let offerPrice = viewModel.offerPrice {
                    Text(offerPrice)
                        .strikethrough()
                }
                Text(viewModel.productPrice)
            }
            
            Button {
                Task {
                    do {
                        try await viewModel.purchasePremium()
                        alert = AlertContext.premiumPurchased
                    } catch StoreError.failedVerification {
                        alert = AlertContext.failedVerification
                    } catch StoreError.pending {
                        alert = AlertContext.pending
                    } catch StoreError.userCancelled {
                        print("user cancelled")
                    } catch {
                        alert = AlertContext.defaultPurchaseError
                    }
                }
            } label: {
                ZStack {
                    Capsule(style: .continuous)
                        .foregroundColor(.accentColor)
                    Text(L10n.BuyPremium.Action.upgrade)
                }
                .frame(width: 200, height: 50)
            }
            .padding()
            
            Button {
                Task {
                    await viewModel.restore()
                }
            } label: {
                Text(L10n.BuyPremium.Action.restore)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(item: $alert, content: { alertItem in
            Alert(title: alertItem.title, dismissButton: .default(Text(L10n.General.dismissButton), action: {
                dismiss()
            }))
        })
        .background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .overlay(Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .imageScale(.small)
                .frame(width: 44, height: 44)
        }, alignment: .topTrailing)
    }
}

struct BuyPremiumView_Previews: PreviewProvider {
    static var previews: some View {
        BuyPremiumView().environmentObject(AppState())
    }
}
