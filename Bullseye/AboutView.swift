//
//  AboutView.swift
//  Bullseye
//
//  Created by Nicolas Isnardi on 2020-12-22.
//  Copyright © 2020 Nicolas Isnardi. All rights reserved.
//

import SwiftUI

struct AboutView: View {
  
  let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255, blue: 179.0 / 255)
  
  struct TextColorStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content.foregroundColor(Color.black)
    }
  }
  
  struct HeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content.modifier(TextColorStyle())
        .font(Font.custom("Arial Rounded MT Bold", size: 30.0))
        .padding(.vertical, 20)
    }
  }
  
  struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content.modifier(TextColorStyle())
        .font(Font.custom("Arial Rounded MT Bold", size: 16.0))
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .padding(.bottom, 20)
    }
  }
  
  var body: some View {
    Group {
      VStack {
        Text("🎯 Bullseye 🎯").modifier(HeadingStyle())
        Text("This is Bullseye the game where you can win points and earn fame by dragging a slider.").modifier(TextStyle())
        Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(TextStyle())
        Text("Enjoy").modifier(TextStyle())
      }
      .navigationBarTitle("About Bulleyes")
      .background(beige)
    }
    .background(Image("Background"), alignment: .center)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
      AboutView().previewLayout(.fixed(width: 896, height: 414))
  }
}
