import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AppState
    @ObservedObject var locationDetailViewModel: LocationDetailViewModel
    @State var showPremiumBuySheet = false
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        ImageSlider(images: UIImage.loadImages(locationDetailViewModel.selectedLocation.imageList))
                            .frame(height: 350)
                        VStack {
                            Spacer()
                            HStack {
                                Text(locationDetailViewModel.selectedLocation.localizedName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)
                                    .padding()
                                    .padding(.bottom, 12)
                                
                                Spacer()
                            }
                            
                        }
                    }.frame(height: 350)
                    
                    SubImageLabels(location: locationDetailViewModel.selectedLocation)
                    
                    DescriptionView(text: locationDetailViewModel.selectedLocation.localizedDescription)
                        .padding(.top)
                    
                }
            }
            ZStack {
                Capsule()
                
                    .foregroundColor(Color.detailActionBarBackground)
                
                HStack {
                    Button {
                        if viewModel.premiumActive {
                            viewModel.getDirectionsToLocation(location: locationDetailViewModel.selectedLocation)
                        } else {
                            showPremiumBuySheet.toggle()
                        }
                    } label: {
                        LocationActionButton(color: Color.customAccentColor, imageName: "location.fill")
                            .padding(.leading)
                    }
                    Button {
                        locationDetailViewModel.favoriteButtonTapped()
                    } label: {
                        LocationActionButton(color: Color.customAccentColor, imageName: locationDetailViewModel.isFavorite ? "heart.fill" : "heart")
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    RatingView(locationDetailViewModel: locationDetailViewModel)
                        .padding(.horizontal)
                }
            }
            .frame(width: 300, height: 60)
            .padding(.bottom)
        }
        .sheet(isPresented: $showPremiumBuySheet, content: {
            BuyPremiumView()
        })
        .foregroundColor(.white)
        .background(
            LinearGradient(gradient: Gradient(colors: [.backgroundStart, .backgroundEnd, .backgroundStart]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .accentColor(.white)
        .ignoresSafeArea(edges: .top)
        .overlay(Button {
            dismiss()
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
    }
}

private struct RatingView: View {
    @EnvironmentObject var viewModel: AppState
    @ObservedObject var locationDetailViewModel: LocationDetailViewModel
    var body: some View {
        HStack(spacing: 20) {
            
            MinusButton(locationDetailViewModel: locationDetailViewModel)
            
            InfoView(color: .brandPrimary, locationDetailViewModel: locationDetailViewModel)
            
            PlusButton(locationDetailViewModel: locationDetailViewModel)
        }
    }
}

private struct MinusButton: View {
    @EnvironmentObject var viewModel: AppState
    @ObservedObject var locationDetailViewModel: LocationDetailViewModel
    
    var body: some View {
        Button {
            if locationDetailViewModel.disableRating {
                return
            }
            switch locationDetailViewModel.ratingState {
            case -1:
                locationDetailViewModel.locationRating.rating += 1
                locationDetailViewModel.ratingState = 0
            case 0:
                locationDetailViewModel.locationRating.rating -= 1
                locationDetailViewModel.ratingState = -1
            case 1:
                locationDetailViewModel.locationRating.rating -= 1
                locationDetailViewModel.ratingState = 0
            default:
                print("not")
            }
            viewModel.updateRatingForSelectedLocation(selectedLocation: locationDetailViewModel.selectedLocation,
                                                      rating: locationDetailViewModel.locationRating)
            
        } label: {
            LocationActionButton(color: .customAccentColor,
                                 imageName: "minus")
            .opacity(locationDetailViewModel.ratingState == -1 ? 0.5 : 1)
        }
    }
    
}

private struct PlusButton: View {
    @EnvironmentObject var viewModel: AppState
    @ObservedObject var locationDetailViewModel: LocationDetailViewModel
    
    var body: some View {
        Button {
            if locationDetailViewModel.disableRating {
                return
            }
            
            switch locationDetailViewModel.ratingState {
            case -1:
                locationDetailViewModel.locationRating.rating += 1
                locationDetailViewModel.ratingState = 0
            case 0:
                locationDetailViewModel.locationRating.rating += 1
                locationDetailViewModel.ratingState = 1
            case 1:
                locationDetailViewModel.locationRating.rating -= 1
                locationDetailViewModel.ratingState = 0
            default:
                print("not")
            }
            viewModel.updateRatingForSelectedLocation(selectedLocation: locationDetailViewModel.selectedLocation,
                                                      rating: locationDetailViewModel.locationRating)
        } label: {
            LocationActionButton(color: .customAccentColor,
                                 imageName: "plus")
            .opacity(locationDetailViewModel.ratingState == 1 ? 0.5 : 1)
        }
    }
    
}

private struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
        
    }
}

private struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 40, height: 40)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 17.5, height: 17.5)
            
        }
    }
}

private struct InfoView: View {
    
    var color: Color
    @ObservedObject var locationDetailViewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.customAccentColor)
                .frame(width: 70, height: 35)
            
            Text("\(locationDetailViewModel.locationRating.rating)")
                .foregroundColor(.white)
                .frame(width: 17, height: 17)
            
        }
    }
}

private struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 16)
    }
}

private struct ImageSlider: View {
    var images: [UIImage]
    var body: some View {
        if images.isEmpty {
            Image(uiImage: PlaceholderImage.banner)
                .resizable()
        } else {
            TabView {
                ForEach(images, id: \.self) { item in
                    Image(uiImage: item)
                        .resizable()
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(locationDetailViewModel: .init(selectedLocation: .preview, appStateViewModel: .init()))
            .environmentObject(AppState())
    }
}
