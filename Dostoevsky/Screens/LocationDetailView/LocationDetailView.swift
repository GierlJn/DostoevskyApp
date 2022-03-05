//
//  LocationDetailView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//
import SwiftUI

struct LocationDetailView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: AppStateViewModel
  @ObservedObject var locationDetailViewModel: LocationDetailViewModel
  
  
  var body: some View {
    
    VStack{
      
      ScrollView{
        
        VStack(spacing: 16){
          
          ZStack{
            ImageSlider(images: UIImage.loadImages(locationDetailViewModel.selectedLocation.imageList))
              .frame(height: 350)
            VStack{
              Spacer()
              HStack{
                Text(locationDetailViewModel.selectedLocation.name.en)
                  .font(.title)
                  .fontWeight(.bold)
                  .lineLimit(1)
                  .minimumScaleFactor(0.75)
                  .padding()
                  .padding(.bottom, 12)
                
                Spacer()
              }
              
            }
          }.frame(height: 350)
          
          HStack {
            Button {
              viewModel.getDirectionsToLocation(location: locationDetailViewModel.selectedLocation)
            } label: {
              AddressView(address: locationDetailViewModel.selectedLocation.address.en)
            }
            
            Spacer()
            
          }
          .padding(.horizontal)
          
          if let date = locationDetailViewModel.selectedLocation.date{
            HStack {
              Button {
                //
              } label: {
                DateView(date: date.en)
              }
              
              Spacer()
              
            }
            .padding(.horizontal)
          }
          
          
          
          DescriptionView(text: locationDetailViewModel.selectedLocation.description.en)
            .padding(.top)
          
        }
      }
      ZStack {
        Capsule()
        
          .foregroundColor(Color(.secondarySystemBackground))
        
        HStack{
          Button {
            viewModel.getDirectionsToLocation(location: locationDetailViewModel.selectedLocation)
          } label: {
            LocationActionButton(color: Color.brandPrimary, imageName: "location.fill")
              .padding(.leading)
          }
          
          Button {
            locationDetailViewModel.favoriteButtonTapped()
          } label: {
            LocationActionButton(color: Color.brandPrimary, imageName: locationDetailViewModel.isFavorite ? "heart.fill" : "heart")
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
    .accentColor(.white)
    .ignoresSafeArea(edges: .top)
    .overlay(Button {
      withAnimation { self.presentationMode.wrappedValue.dismiss() }
    } label: {
      XDismissButton()
    }, alignment: .topTrailing)
  }
}

private struct RatingView: View{
  @EnvironmentObject var viewModel: AppStateViewModel
  @ObservedObject var locationDetailViewModel: LocationDetailViewModel
  var body: some View{
    HStack(spacing: 20) {
      
      MinusButton(locationDetailViewModel: locationDetailViewModel)
      
      InfoView(color: .brandPrimary, locationDetailViewModel: locationDetailViewModel)
      
      PlusButton(locationDetailViewModel: locationDetailViewModel)
    }
  }
}

private struct MinusButton: View{
  @EnvironmentObject var viewModel: AppStateViewModel
  @ObservedObject var locationDetailViewModel: LocationDetailViewModel
  
  var body: some View{
    Button {
      if locationDetailViewModel.disableRating {
        return
      }
      switch locationDetailViewModel.ratingState{
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
      viewModel.updateRatingForSelectedLocation(selectedLocation: locationDetailViewModel.selectedLocation, rating: locationDetailViewModel.locationRating)
      
    } label: {
      LocationActionButton(color: .brandPrimary, imageName: "minus").opacity(locationDetailViewModel.ratingState == -1 ? 0.5 : 1)
    }
    
  }
  
}

private struct PlusButton: View{
  @EnvironmentObject var viewModel: AppStateViewModel
  @ObservedObject var locationDetailViewModel: LocationDetailViewModel
  
  var body: some View{
    Button {
      if locationDetailViewModel.disableRating {
        return
      }
      
      switch locationDetailViewModel.ratingState{
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
      viewModel.updateRatingForSelectedLocation(selectedLocation: locationDetailViewModel.selectedLocation, rating: locationDetailViewModel.locationRating)
    } label: {
      LocationActionButton(color: .brandPrimary, imageName: "plus").opacity(locationDetailViewModel.ratingState == 1 ? 0.5 : 1)
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

private struct AddressView: View {
  
  var address: String
  
  var body: some View {
    Label(address, systemImage: "mappin.and.ellipse")
      .font(.caption)
      .foregroundColor(.secondary)
  }
}

private struct DateView: View {
  
  var date: String
  
  var body: some View {
    Label(date, systemImage: "calendar")
      .font(.caption)
      .foregroundColor(.secondary)
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
        .foregroundColor(color)
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

private struct ImageSlider: View{
  var images: [UIImage]
  var body: some View{
    if images.isEmpty{
      Image(uiImage: PlaceholderImage.banner)
        .resizable()
    }else{
      TabView{
        ForEach(images, id: \.self) { item in
          Image(uiImage: item)
            .resizable()
          
        }
      }
      .tabViewStyle(PageTabViewStyle())
    }
  }
}

