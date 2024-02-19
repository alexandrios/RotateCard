//
//  CardFlipHero.swift
//  RotateCard
//
//  Created by Alexander Plotnikov on 12.12.2023.
//

import SwiftUI

struct CardFlipHero: View {

    var number: Int
    var srbValue: String
    var rusValue: String

    @AppStorage("currentCardNumber") var currentCardNumber: Int?
    @State var isFlip: Bool = false
    
    var body : some View {
        
        /*
         let resetBackButton = Button(action: { self.isFlip = true }) { Text("Back")}.disabled(isFlip == true)
         let resetFrontButton = Button(action: { self.isFlip = false }) { Text("Front")}.disabled(isFlip == false)
         let animatedToggle = Button(action: {
         withAnimation(Animation.linear(duration: 0.8)) {
         self.isFlip.toggle()
         }
         }) { Text("Toggle")}
         */
        
        VStack() {
            /*
             HStack() {
             resetFrontButton
             Spacer()
             animatedToggle
             Spacer()
             resetBackButton
             }.padding()
             */
            Spacer()
            FlipView (
                //front: CardFace(text: "press here for flip", colorBg: .gray),
                //back: CardBack(),
                front: CardSrb(text: srbValue, number: number),
                back: CardRus(text: rusValue, number: number),
                number: number,
                showBack: $isFlip)
            Spacer()
        }
        .offset(currentCardNumber == number ? .zero :
                    CGSize(width: Int.random(in: -10...10), height: Int.random(in: -10...10)))
    }
}

struct FlipView<FrontView: View, BackView: View>: View {
    
    let front: FrontView
    let back: BackView
    let number: Int
    @Binding var showBack: Bool
    
    @AppStorage("currentCardNumber") var currentCardNumber: Int?
    
    enum DragSide {
        case NONE, LEFT, RIGHT
    }
    
    @State private var dragSide: DragSide = DragSide.NONE
    @State private var dragAmount = CGSize.zero

    func active() -> Bool {
        return self.number == currentCardNumber
    }
    
    var body: some View {
        
        ZStack() {
            front
                .modifier(FlipOpacity(percentage: showBack ? 0 : 1))
                .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (0.001, 1, 0.001))
            back
                .modifier(FlipOpacity(percentage: showBack ? 1 : 0))
                .rotation3DEffect(Angle.degrees(showBack ? 0 : 180), axis: (0.001, 1, 0.001))
        }
        .onTapGesture {
            //print("self.number=\(self.number)")
            //print("currentCardNumber=\(currentCardNumber)")
            if (active()) {
                withAnimation(Animation.linear(duration: 0.2)) {
                    self.showBack.toggle()
                }
            }
        }
        
        .offset(CGSize(width: dragAmount.width, height: dragAmount.height * 1.5))
        .animation(.linear(duration: 0.2), value: dragAmount)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if (active()) {
                        dragAmount = gesture.translation
                        //print(dragAmount)
                        if (gesture.translation.width > 20) {
                            dragSide = .RIGHT
                        } else if (gesture.translation.width < -20) {
                            dragSide = .LEFT
                        } else {
                            dragSide = .NONE
                        }
                    }
                }
                .onEnded { _ in
                    //print(dragSide)
                    if (dragSide == .NONE) {
                        dragAmount = .zero
                    } else if (dragSide == .LEFT) {
                        dragAmount =  CGSize(width: -350, height: dragAmount.height)
                        currentCardNumber = currentCardNumber! - 1
                    } else if (dragSide == .RIGHT) {
                        dragAmount =  CGSize(width: 350, height: dragAmount.height)
                        currentCardNumber = currentCardNumber! - 1
                    }
                }
        )
    }
}

private struct FlipOpacity: Animatable, ViewModifier { //} AnimatableModifier {
   var percentage: CGFloat = 0
   
   var animatableData: CGFloat {
      get { percentage }
      set { percentage = newValue }
   }
   
    func body(content: Content) -> some View {
        content
            .opacity(Double(percentage.rounded()))
    }
}


struct CardBase : View {
    
    @AppStorage("currentCardNumber") var currentCardNumber: Int?
    
    var text: String
    var foregr: Color
    var backgr: Color
    var number: Int
    
    var body: some View {
        //Text(currentCardNumber == number ? text : "")
        Text(text)
                .font(.largeTitle)
                .foregroundColor(foregr)
                .multilineTextAlignment(.center)
                .padding(5)
                .frame(width: 250, height: 420)
                .background(backgr, in: RoundedRectangle(cornerRadius: 20))
        }
}

struct CardSrb : View {
    
    var text : String
    var number: Int
    
    let backgr = Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
    let foregr = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))

    var body: some View {
        CardBase(text: text, foregr: foregr, backgr: backgr, number: number)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 2)
            }
    }
}

struct CardRus: View {
    
    var text : String
    var number: Int
    
    let backgr = Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
    let foregr = Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    
    var body: some View {
        CardBase(text: text, foregr: foregr, backgr: backgr, number: number)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 2)
            }
    }
}


struct CardFlipHero_Preview: PreviewProvider {
    static var previews: some View {
        CardFlipHero(number: 9, srbValue: "nameštaj", rusValue: "мебель")
    }
}

