//
//  OnBoardView.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 23.02.22.
//

import SwiftUI



struct OnBoardView: View {
  
  var body: some View {
      VStack{
        Text("Dostoevsky's Petersburg")
          .font(.title).bold()
          .foregroundColor(.white)
          .padding(.horizontal)
        Text("Fyodor Mikhailovich Dostoyevsky lived in the city about 28 years in total. This is where he developed as a writer")
          .foregroundColor(.white)
          .padding(.horizontal)
        Spacer()
      }
    
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
