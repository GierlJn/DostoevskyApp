//
//  AnimatedListButton.swift
//  SwiftUICustomViews
//
//  Created by Julian Gierl on 21.03.22.
//
import SwiftUI


struct AnimatedListButton: View {
    
  @Binding var isRotating: Bool
  @Binding var isHidden: Bool
    
    var body: some View {
      ZStack{
        VStack(spacing: 10){
            Rectangle()
                .frame(width: 34, height: 4)
                .cornerRadius(4)
                .rotationEffect(.degrees(isRotating ? 0 : 0), anchor: .leading)
                .offset(x: 0, y: isRotating ? 10 : 0)
            
            Rectangle()
                .frame(width: 34, height: 4)
                .cornerRadius(4)
                .scaleEffect(isHidden ? 0 : 1, anchor: isHidden ? .trailing: .leading)
                .opacity(isHidden ? 0 : 1)
                .rotationEffect(.degrees(isRotating ? 90: 0) )
            
            Rectangle()
                .frame(width: 34, height: 4)
                .cornerRadius(4)
                .rotationEffect(.degrees(isRotating ? 0 : 0), anchor: .leading)
                .offset(x: 0, y: isRotating ? -10 : 0)
        }
      }
    }
}

struct AnimatedListButtonPreviewContainer: View{
  @State var isPressed = false
  var body: some View{
    AnimatedListButton(isRotating: $isPressed, isHidden: $isPressed)
      .onTapGesture {
        withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)){
          isPressed.toggle()
        }
      }
  }
}

struct AnimatedListButton_Previews: PreviewProvider {
    static var previews: some View {
      AnimatedListButtonPreviewContainer()
            .preferredColorScheme(.dark)
    }
}



