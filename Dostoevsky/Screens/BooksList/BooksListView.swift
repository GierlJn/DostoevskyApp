import SwiftUI

struct BooksListView: View {
    @StateObject var bookListViewModel = BookListViewModel()
    @EnvironmentObject var viewModel: AppState
    @State var categories = Categories.allCases
    @State var sortSettings = SortType.date
    @State var book: Book

    var body: some View {
        VStack {
            List {
                Section(header: HStack {
                    HStack {
                        Spacer()
                        Spacer()
                        Menu(L10n.Compactlist.Action.sort) {
                            Picker(selection: $sortSettings, label: Text(L10n.Compactlist.Action.sort)) {
                                Text(L10n.Compactlist.Sort.Option.rating).tag(SortType.rating)
                                Text(L10n.Compactlist.Sort.Option.favorites).tag(SortType.favorite)
                            }
                        }
                    }
                }) {
                    ForEach(bookListViewModel.sortLocations(locations: viewModel.locations.novelFilteredLocations(for: book.en), sortType: sortSettings, appState: viewModel), id: \.self) { location in
                        Button {
                            DispatchQueue.main.async {
                                viewModel.selectedLocation = location
                                viewModel.showDetail = ActiveStatus.active
                            }
                        } label: {
                            LocationCell(viewModel: viewModel, location: location)
                        }
                    }
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .accentColor(.white)
        .navigationTitle(book.localizedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
