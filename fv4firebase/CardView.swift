//
//  CardView.swift
//  v3bill
//
//  Created by applwes on 2024-11-30.
//

import SwiftUI

struct CardView: View {
    
   
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    var person: String
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 320, height: 420)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundColor(color.opacity(0.9))
                .shadow(radius: 4)
            HStack  {
                Text(person)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
        
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        withAnimation {changeColor(width: offset.width)
                            
                        }
                    } .onEnded { _ in
                        withAnimation {
                            swipeCard(width: offset.width)
                            changeColor(width: offset.width)                        }
                    }
                
            )
        
    }
    func swipeCard(width: CGFloat) {
      switch width {
      case -500...(-150):
          print("\(person) removed")
          offset = CGSize(width: -500, height: 0)
          case 150...500:
          print("\(person) added")
          offset = CGSize(width: 500, height: 0)
      default:
          offset = .zero
      }
    }
   
    func changeColor(width:CGFloat) {
      switch width {

      case -500...(-130):
          color = Color.red
      case 130...500:
          color = Color.green
      default:
          color = Color.white
    }
    
    }
    
}

    struct CardView_Previews: PreviewProvider {
        static var previews: some View { CardView(person: "Mario")
        
    }
}
