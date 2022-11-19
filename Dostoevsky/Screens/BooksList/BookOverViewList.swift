import SwiftUI

struct BookOverViewList: View {
    
    @State var books = BookManager.books
    @EnvironmentObject var viewModel: AppState
    
    var body: some View {
        NavigationView {
            Group {
                if books.isEmpty {
                    EmptyView()
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(books, id: \.self) { book in
                            VStack(alignment: .leading) {
                                if viewModel.premiumActive {
                                    NavigationLink {
                                        BooksListView(book: book)
                                    } label: {
                                        VStack {
                                            book.image
                                                .resizable()
                                                .frame(height: 200)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .padding(.vertical, 20)
                                            
                                            Text(book.localizedName)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.75)
                                                .padding(.horizontal)
                                        }
                                    }
                                } else {
                                    Button {
                                        viewModel.showBuyPremiumSheet.toggle()
                                    } label: {
                                        VStack {
                                            book.image
                                                .resizable()
                                                .frame(height: 200)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .padding(.vertical, 20)
                                            
                                            Text(book.localizedName)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.75)
                                                .padding(.horizontal)
                                        }
                                        .opacity(0.5)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .navigationBarHidden(false)
            .navigationTitle("Books")
        }
    }
}
