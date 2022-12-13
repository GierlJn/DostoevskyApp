import SwiftUI

struct LeadingLocationCell: View {
    @ObservedObject var viewModel: AppState

    var location: DLocation

    var body: some View {
        VStack {
            HStack {
                CellTitleVStack(alignment: .trailing, location: location)
                    .padding(.trailing)
                
                CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner,
                              rating: viewModel.getRatingForLocation(location: location).rating,
                              isFavorite: PersistanceManager.isFavorite(location))
            }
            .padding(.vertical)
            Text(location.localizedDescription)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
        }
    }
}
