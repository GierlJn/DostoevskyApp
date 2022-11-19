import SwiftUI

struct TrailingLocationCell: View {
    @ObservedObject var viewModel: AppState
    
    var location: DLocation
    
    var body: some View {
        VStack {
            HStack {
                CellImageView(image: UIImage.loadImages(location.imageList).first ?? PlaceholderImage.banner,
                              rating: viewModel.getRatingForLocation(location: location).rating,
                              isFavorite: location.isFavorite)
                
                CellTitleVStack(alignment: .leading, location: location)
                    .padding(.leading)
                
            }
            .padding(.horizontal)
            Text(location.localizedDescription)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
        }

    }
    
}

struct MirroredLocationCell_Previews: PreviewProvider {
    
    static var previews: some View {
        TrailingLocationCell(viewModel: AppState(), location: MockData.createMockLocation())
    }
}
