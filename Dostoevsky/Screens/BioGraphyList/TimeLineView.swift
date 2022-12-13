import SwiftUI

struct TimeLineView: View {
    @EnvironmentObject var viewModel: AppState
    @State var categories = Categories.allCases
    @State var sortSettings = Array(repeating: SortType.date, count: Categories.allCases.count)
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(Array(viewModel.locations.biographyLocations.enumerated()), id: \.offset) { index, _ in
                    let location = viewModel.locations.biographyLocations[index]
                    Button {
                        viewModel.selectedLocation = location
                        viewModel.showDetail = ActiveStatus.active
                    } label: {
                        switch index {
                        case _ where index == 0 || index >= viewModel.locations.biographyLocations.count - 1:
                            StartingLocationCell(viewModel: viewModel, location: location)
                        case _ where index % 2 == 0:
                            LeadingLocationCell(viewModel: viewModel, location: location)
                        case _ where index % 2 != 0:
                            TrailingLocationCell(viewModel: viewModel, location: location)
                        default:
                            EmptyView()
                        }
                    }
                    if index < viewModel.locations.biographyLocations.count - 1 {
                        Spacer().frame(height: 20)
                        ConnectingLine()
                            .stroke(.secondary, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [10], dashPhase: 1))
                            .frame(width: 3, height: 90)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .accentColor(.white)
        .background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .sheet(item: $viewModel.showDetail, content: { _ in
            LocationDetailView(locationDetailViewModel: LocationDetailViewModel(selectedLocation: viewModel.selectedLocation!,
                                                                                appStateViewModel: viewModel))
        })
    }

    func sortLocations(locations: [DLocation], sortType: SortType) -> [DLocation] {
        switch sortType {
        case .date:
            return locations.sorted(by: { $0.id < $1.id })
        case .rating:
            return locations.sorted(by: { viewModel.getRatingForLocation(location: $0).rating > viewModel.getRatingForLocation(location: $1).rating })
        case .favorite:
            return locations.sorted { loc1, loc2 in
                loc1.isFavorite && !loc2.isFavorite
            }
        }
    }

    func filteredLocations(for category: Categories) -> [DLocation] {
        viewModel.showingFavorites ? viewModel.locations.filter { $0.definedCategory == category }.filter({ loc in
            loc.isFavorite
        }) : viewModel.locations.filter { $0.definedCategory == category }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environmentObject(AppState())
    }
}
