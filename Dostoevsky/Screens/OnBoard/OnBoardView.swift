//
//  OnBoardView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 23.02.22.
//

import SwiftUI

struct OnBoardView: View {

  @State var animatedOpacity: Double = 0
  @State var offset: CGFloat = 150
  @EnvironmentObject var appState: AppState

  var body: some View {
    ZStack {
      GeometryReader { reader in
        VStack(spacing: 0) {
          Color.black.frame(height: reader.size.height*0.2)
          LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
            .frame(height: reader.size.height*0.8)
        }
        .allowsHitTesting(false)
      }.ignoresSafeArea(edges: .horizontal)
      VStack {
          Text(L10n.Onboard.header)
          .font(.title).bold().underline()
          .foregroundColor(.white)
          .padding(.top)
          .minimumScaleFactor(0.7)
          .offset(x: 0, y: offset)

        if !CommandLine.arguments.contains("--UITests") {
          Text("Fyodor Mikhailovich Dostoyevsky lived in the city about 28 years in total. His characters inhabit the streets of the city and come to life on the pages of his books.")
            .foregroundColor(.white)
            .padding()
            .opacity(animatedOpacity)
        }

        Button(action: {
          appState.showsOnboard = false
        }, label: {
            Text(L10n.Onboard.action)
            .foregroundColor(.black)
            .padding()
            .background {
              RoundedRectangle(cornerRadius: 15)
                .frame(width: 130)
                .foregroundColor(.white)
            }
        })
        .accessibilityIdentifier(AccessibilityIdentifier.exploreButton)
        .accentColor(.black)
        .padding(.top)
        .opacity(animatedOpacity)

        Spacer()
      }
      .padding()
    }
    .onAppear(perform: {
      if CommandLine.arguments.contains("--UITests") {
        offset = 0
        animatedOpacity = 1
      } else {
        withAnimation(.linear(duration: 0.5).delay(3)) {
          offset = 0
        }
        withAnimation(.linear(duration: 1).delay(4)) {
          animatedOpacity = 1
        }
      }
    })
    .background {
      OnBoardImagesView()
    }
  }
}

struct OnBoardView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardView()
  }
}
