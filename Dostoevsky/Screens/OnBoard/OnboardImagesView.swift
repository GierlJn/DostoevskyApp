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
  @State var offset: CGFloat = 1000

  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 5) {
          ForEach(mockImages, id: \.self) { image in
            Image(uiImage: image)
              .resizable()
              .frame(width: 100, height: 100)
              .cornerRadius(12)
          }
        }
      }
      .frame(height: 1000)
      .offset(x: 0, y: offset)
      .rotation3DEffect(.degrees(45  ), axis: (x: 1, y: 0, z: 0))
    }
    .background(.black)
    .onAppear {
      let locations = Bundle.main.decode([DLocation].self, from: "locations.json")
      mockImages = locations.map({ location in
        UIImage(named: location.imageList.first!) ?? PlaceholderImage.banner
      })

      if CommandLine.arguments.contains("--UITests") {
        offset = 0} else {
        withAnimation(.easeIn(duration: 0.5).delay(3)) {
          offset = 0
        }
      }

    }
  }
}

struct OnBoardImagesView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardImagesView()
  }
}

extension View {
  func animate(using animation: Animation = .easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
    onAppear {
      withAnimation(animation) {
        action()
      }
    }
  }
}

extension View {
  func animateForever(using animation: Animation = .easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
    let repeated = animation.repeatForever(autoreverses: autoreverses)

    return onAppear {
      withAnimation(repeated) {
        action()
      }
    }
  }
}
