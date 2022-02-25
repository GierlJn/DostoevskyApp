//
//  LocationDetailView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//
import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    var selectedLocation: DLocation?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            if viewModel.selectedLocation != nil{
                VStack(spacing: 32) {
                    BannerImageView(image: viewModel.selectedLocation!.createBannerImage())
                        .padding(.bottom,16)
                    
                    HStack {
                        Button {
                            viewModel.getDirectionsToLocation()
                        } label: {
                            AddressView(address: viewModel.selectedLocation!.streetName)
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    DescriptionView(text: viewModel.selectedLocation!.description)
                    Spacer()
                    ZStack {
                        Capsule()
                            .frame(height: 80)
                            .foregroundColor(Color(.secondarySystemBackground))
                        
                        HStack(spacing: 20) {
                            
                            Button {
                                if viewModel.disableRating {
                                    return
                                }
                                switch viewModel.ratingState{
                                case -1:
                                    viewModel.selectedLocation!.rating += 1
                                    viewModel.ratingState = 0
                                case 0:
                                    viewModel.selectedLocation!.rating -= 1
                                    viewModel.ratingState = -1
                                case 1:
                                    viewModel.selectedLocation!.rating -= 1
                                    viewModel.ratingState = 0
                                default:
                                    print("not")
                                }

                                
                                
                                viewModel.updateSelectedLocation()
                                viewModel.updateLocationRating()
                            } label: {
                                LocationActionButton(color: .brandPrimary, imageName: "minus").opacity(viewModel.ratingState == -1 ? 0.5 : 1)
                            }
                            
                            InfoView(color: .brandPrimary, text: "\(viewModel.selectedLocation!.rating)")
                            
                            Button {
                                if viewModel.disableRating {
                                    return
                                }
                                
                                switch viewModel.ratingState{
                                case -1:
                                    viewModel.selectedLocation!.rating += 1
                                    viewModel.ratingState = 0
                                case 0:
                                    viewModel.selectedLocation!.rating += 1
                                    viewModel.ratingState = 1
                                case 1:
                                    viewModel.selectedLocation!.rating -= 1
                                    viewModel.ratingState = 0
                                default:
                                    print("not")
                                }
                                
                                
                                viewModel.updateSelectedLocation()
                                viewModel.updateLocationRating()
                            } label: {
                                LocationActionButton(color: .brandPrimary, imageName: "plus").opacity(viewModel.ratingState == 1 ? 0.5 : 1)
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    
                }
            }
            
            
            
            
        }

        .accentColor(.white)
        .onAppear(perform: {
            guard let selectedLocation = selectedLocation else {
                return
            }
            viewModel.setup(location: selectedLocation)
        })
        
        .overlay(Button {
            withAnimation { self.presentationMode.wrappedValue.dismiss() }
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
        
    }
}


private struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
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


private struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
            
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
                .frame(width: 70, height: 50)
            
            Text(text)
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
            
        }
    }
}


private struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}

struct LocationDetailView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            LocationDetailView(viewModel: LocationDetailViewModel())
        }
    }
}
