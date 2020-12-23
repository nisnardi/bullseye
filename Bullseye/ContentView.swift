//
//  ContentView.swift
//  Bullseye
//
//  Created by Nicolas Isnardi on 2020-11-13.
//  Copyright © 2020 Nicolas Isnardi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var roundNumber = 1
  
  let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
  
    struct LabelStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content.foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 18.0))
        .modifier(ShadowStyle())
      }
    }
  
    struct ShadowStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content.shadow(color: Color.black, radius: 5, x: 2.0, y: 2.0)
      }
    }
    
    struct ValueStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content.foregroundColor(Color.yellow)
          .font(Font.custom("Arial Rounded MT Bold", size: 24.0))
          .modifier(ShadowStyle())
      }
    }
    
    struct ButtonLargeStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content.foregroundColor(Color.black)
          .font(Font.custom("Arial Rounded MT Bold", size: 18.0))
      }
    }
    
    struct ButtonSmallStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content.foregroundColor(Color.black)
          .font(Font.custom("Arial Rounded MT Bold", size: 12.0))
      }
    }
  
    var body: some View {
      VStack {
        Spacer()
        // Target Row
        HStack {
          Text("Put the bulleye as close as you can to:").modifier(LabelStyle())
          Text("\(target)").modifier(ValueStyle())
        }
        Spacer()
        // Slider Row
        HStack {
          Text("1").modifier(LabelStyle())
          Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
          Text("100").modifier(LabelStyle())
        }
        Spacer()
        // Hit me Button Row
        Button(action: {
          print("Button pressed!!")
          self.alertIsVisible = true
        }) {
          Text("Hit Me!")
          .modifier(ButtonLargeStyle())
        }
        .background(Image("Button"))
        .modifier(ShadowStyle())
 
        .alert(isPresented: $alertIsVisible) { () -> Alert in
          return Alert(
            title: Text("\(alertTitle())"),
            message: Text("The Slider value is: \(sliderValueRounded()).\n" +
              "You scored \(pointsForCurrentRound()) points this round"
            ),
            dismissButton: .default(Text("Awesome")) {
              self.target = self.generateRandomTarget()
              self.score += self.pointsForCurrentRound()
              
              self.roundNumber += 1
            })
        }
        Spacer()
        // Control Row
        HStack {
          Button(action: {
            self.startNewGame()
          }) {
            HStack {
              Image("StartOverIcon")
              Text("Start over").modifier(ButtonSmallStyle())
            }
          }
          .background(Image("Button"))
          .modifier(ShadowStyle())
          Spacer()
          Text("Score:").modifier(LabelStyle())
          Text("\(score)").modifier(ValueStyle())
          Spacer()
          Text("Round:").modifier(LabelStyle())
          Text("\(roundNumber)").modifier(ValueStyle())
          Spacer()
          NavigationLink(destination: AboutView()) {
            HStack {
              Image("InfoIcon")
              Text("Info").modifier(ButtonSmallStyle())
            }
          }
          .background(Image("Button"))
          .modifier(ShadowStyle())
        }
        .padding(.bottom, 20)
      }
      .background(Image("Background"), alignment: .center)
      .accentColor(midnightBlue)
      .navigationBarTitle("Bulleyes")
  }
  
  func amountOff() -> Int {
    abs(target - sliderValueRounded())
  }
  
  func generateRandomTarget() -> Int {
    Int.random(in: 1...100)
  }

  func sliderValueRounded() -> Int {
    Int(sliderValue.rounded())
  }
  
  func pointsForCurrentRound() -> Int {
    let maxiumScore = 100
    let difference = amountOff()
    let bonus: Int
    
    if difference == 0 {
      bonus = 100
    } else if difference == 1 {
      bonus = 50
    }else {
      bonus = 0
    }
    
    return maxiumScore - difference + bonus
  }
  
  func alertTitle() -> String {
    let difference = amountOff()
    // Can use let as it's only assigned once.
    let title: String
    
    if difference == 0 {
      title = "Perfect!!"
    } else if difference < 5 {
      title = "You almost had it!!"
    } else if difference < 10 {
      title = "Not Bad"
    } else {
      title = "Are you even trying?"
    }
    
    return title
  }
  
  func startNewGame() -> Void {
   sliderValue = 50.0
   target = Int.random(in: 1...100)
   score = 0
   roundNumber = 1
  }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
