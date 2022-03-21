//
//  AnimatedListButton.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 21.03.22.
//

import SwiftUI


struct AnimatedListButton: View {
  
  
  @Binding var isPressed: Bool
  
  var body: some View {
    ZStack{
      VStack(spacing: 14){
        
        Rectangle() // top
          .frame(width: 20, height: 10)
          .cornerRadius(4)
          .rotationEffect(.degrees(isPressed ? 0 : 0), anchor: .leading)
          .offset(x: 0, y: isPressed ? 10 : 0)
        
        Rectangle() // middle
          .frame(width: 20, height: 10)
          .cornerRadius(4)
          .scaleEffect(isPressed ? 0 : 1, anchor: isPressed ? .trailing: .leading)
          .opacity(isPressed ? 0 : 1)
          .rotationEffect(.degrees(isPressed ? 90: 0) )
        
        Rectangle() // bottom
          .frame(width: 20, height: 10)
          .cornerRadius(4)
          .rotationEffect(.degrees(isPressed ? 0 : 0), anchor: .leading)
          .offset(x: 0, y: isPressed ? -10 : 0)
      }
    }
  }
}

struct AnimatedListButton_Previews: PreviewProvider {
  static var previews: some View {
    AnimatedListButton(isPressed: .constant(true))
      .preferredColorScheme(.dark)
  }
}
