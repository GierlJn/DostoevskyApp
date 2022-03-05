//
//  LocationDetailView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//
import SwiftUI

struct LocationDetailView: View {
    
    @EnvironmentObject var viewModel: AppStateViewModel
    
    var selectedLocation: DLocation?
    @Environment(\.presentationMode) var presentationMode
    @State var userIsSwiping = false
    @State var locationRating = 0
    
    var body: some View {
        if viewModel.selectedLocation != nil{
            VStack(){
                
                ScrollView{
                    
                    VStack(spacing: 16){
                        
                        ZStack{
                            ImageSlider(images: UIImage.loadImages(viewModel.selectedLocation!.imageList))
                                .frame(height: 350)
                            VStack{
                                Spacer()
                                HStack{
                                    Text(viewModel.selectedLocation!.name.en)
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
                                viewModel.getDirectionsToLocation()
                            } label: {
                                AddressView(address: viewModel.selectedLocation!.address.en)
                            }
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        
                        if (viewModel.selectedLocation!.date.en != ""){
                            HStack {
                                Button {
                                    //
                                } label: {
                                    DateView(date: viewModel.selectedLocation!.date.en)
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        
                        DescriptionView(text: viewModel.selectedLocation!.description.en)
                            .padding(.top)
                        
                    }
                }
                ZStack {
                    Capsule()
                        
                        .foregroundColor(Color(.secondarySystemBackground))
                        
                    HStack{
                        Button {
                            viewModel.getDirectionsToLocation()
                        } label: {
                            LocationActionButton(color: Color.brandPrimary, imageName: "location.fill")
                                .padding(.leading)
                        }
                        
                        Button {
                            viewModel.favoriteButtonTapped()
                        } label: {
                            LocationActionButton(color: Color.brandPrimary, imageName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .padding(.leading)
                        }
                        
                        Spacer()

                        RatingView(viewModel: viewModel, locationRating: $locationRating)
                            .padding(.horizontal)
                    }
                }
                .frame(width: 300, height: 60)
                .padding(.bottom)
                
            }
            .accentColor(.white)
            .onAppear(perform: {
                guard let selectedLocation = selectedLocation else {
                    return
                }
                viewModel.setup(location: selectedLocation)
            })
            .ignoresSafeArea(edges: .top)
            .overlay(Button {
                withAnimation { self.presentationMode.wrappedValue.dismiss() }
            } label: {
                XDismissButton()
            }, alignment: .topTrailing)
            .onAppear {
                self.locationRating = viewModel.getRatingForLocation(location: viewModel.selectedLocation!).rating
            }
        }else{
            EmptyView()
        }
            
        
    }
}

private struct RatingView: View{
    @ObservedObject var viewModel: AppStateViewModel
    @Binding var locationRating: Int
    var body: some View{
        HStack(spacing: 20) {
            
            Button {
                if viewModel.disableRating {
                    return
                }
                switch viewModel.ratingState{
                case -1:
                    locationRating += 1
                    viewModel.ratingState = 0
                case 0:
                    locationRating -= 1
                    viewModel.ratingState = -1
                case 1:
                    locationRating -= 1
                    viewModel.ratingState = 0
                default:
                    print("not")
                }
                
                
                viewModel.updateRatingForSelectedLocation(locationRating)
                //viewModel.updateSelectedLocation()
                
            } label: {
                LocationActionButton(color: .brandPrimary, imageName: "minus").opacity(viewModel.ratingState == -1 ? 0.5 : 1)
            }
            
            
            InfoView(color: .brandPrimary, text: "\(viewModel.getRatingForLocation(location: viewModel.selectedLocation!).rating)")
            
            PlusButton(viewModel: viewModel, locationRating: $locationRating)
        }
    }
}

private struct PlusButton: View{
    @ObservedObject var viewModel: AppStateViewModel
    @Binding var locationRating: Int
    
    var body: some View{
        Button {
            if viewModel.disableRating {
                return
            }
            
            switch viewModel.ratingState{
            case -1:
                locationRating += 1
                viewModel.ratingState = 0
            case 0:
                locationRating += 1
                viewModel.ratingState = 1
            case 1:
                locationRating -= 1
                viewModel.ratingState = 0
            default:
                print("not")
            }
            
            
            viewModel.updateRatingForSelectedLocation(locationRating)
            //viewModel.updateSelectedLocation()
        } label: {
            LocationActionButton(color: .brandPrimary, imageName: "plus").opacity(viewModel.ratingState == 1 ? 0.5 : 1)
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
    var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(color)
                .frame(width: 70, height: 35)
            
            Text(text)
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


struct ImageSlider: View{
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

