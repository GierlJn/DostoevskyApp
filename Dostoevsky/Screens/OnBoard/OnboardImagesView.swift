//
//  OnBoardView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 23.02.22.
//

import SwiftUI



struct OnBoardImagesView: View {
  
  @State var mockImages = [UIImage]()
  let columns: [GridItem] = Array(repeating: .init(.fixed(101)), count: 5)
  
  var body: some View {
        VStack{
          ScrollView{
            LazyVGrid(columns: columns, spacing: 5) {
              ForEach(mockImages, id:\.self){ image in
                Image(uiImage: image)
                  .resizable()
                  .frame(width: 100, height: 100)
                  .cornerRadius(12)
              }
            }
          }
          .frame(height: 1000)
          .overlay{
            GeometryReader{ reader in
              VStack(spacing: 0){
                Color.black.frame(height:reader.size.height*0.2)
                LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
                  .frame(height:reader.size.height*0.8)
              }
              
                .allowsHitTesting(false)
            }.ignoresSafeArea(edges: .horizontal)

          }
          .rotation3DEffect(.degrees(45  ), axis: (x: 1, y: 0, z: 0))
        }
    .background(.black)
    .onAppear {
      let locations = Bundle.main.decode([DLocation].self, from: "locations.json")
      mockImages = locations.map({ location in
        UIImage(named: location.imageList.first!) ?? PlaceholderImage.banner
      })
    }
    
    
  }
}

struct OnBoardImagesView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardImagesView()
  }
}
