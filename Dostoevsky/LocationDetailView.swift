//
//  LocationDetailView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 30.08.21.
//
import SwiftUI

struct LocationDetailView: View {

    var location: DLocation
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                BannerImageView(image: location.createImage())
                
                HStack {
                    AddressView(address: location.streetName)
                    Spacer()
                }
                .padding(.horizontal)
                
                DescriptionView(text: location.description)
                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                    

                .padding(.horizontal)

                Spacer()
            }
        }

     
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
}


struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    
    var address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}
