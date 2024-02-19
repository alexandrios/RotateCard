//
//  CardsView.swift
//  RotateCard
//
//  Created by Alexander Plotnikov on 19.02.2024.
//

import SwiftUI

struct CardsView: View {
    
    @StateObject var cardsViewModel: CardsViewModel = CardsViewModel()
    
    var body: some View {
        @AppStorage("currentCardNumber") var currentCardNumber: Int?
        
        let cards = cardsViewModel.getData()
        
        currentCardNumber = cards.count
        
        
        return ZStack {
            Button(action: {
                currentCardNumber = cards.count
            }, label: {
                Text("Reload")
            })
                
            showCards(cards: cards)

        }
    }
    
    func showCards(cards: [Card]) -> some View {
        
        //let cards = cardsViewModel.getData()
        
        return
            ForEach(0 ..< cards.count, id: \.self) {value in
                CardFlipHero(number: value + 1,
                             srbValue: cards[value].srbValue,
                             rusValue: cards[value].rusValue)
            }
        
            /*
            CardFlipHero(number: 1, srbValue: "nameštaj", rusValue: "мебель")
            CardFlipHero(number: 2, srbValue: "stan", rusValue: "квартира")
            CardFlipHero(number: 3, srbValue: "soba", rusValue: "комната")
            CardFlipHero(number: 4, srbValue: "sprat", rusValue: "этаж")
            CardFlipHero(number: 5, srbValue: "zgrada", rusValue: "здание")
            CardFlipHero(number: 6, srbValue: "novogradnja", rusValue: "новостройка")
            CardFlipHero(number: 7, srbValue: "vikendica", rusValue: "дача")
            CardFlipHero(number: 8, srbValue: "nekretnina", rusValue: "недвижимость")
            CardFlipHero(number: 9, srbValue: "kuća", rusValue: "дом")
             */
        
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
