//
//  ContentView.swift
//  RotateCard
//
//  Created by Alexander Plotnikov on 12.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body : some View {
        
        @AppStorage("currentCardNumber") var currentCardNumber: Int?
        
        currentCardNumber = 9
        
        return ZStack {
            CardFlipHero(number: 1, srbValue: "nameštaj", rusValue: "мебель")
            CardFlipHero(number: 2, srbValue: "stan", rusValue: "квартира")
            CardFlipHero(number: 3, srbValue: "soba", rusValue: "комната")
            CardFlipHero(number: 4, srbValue: "sprat", rusValue: "этаж")
            CardFlipHero(number: 5, srbValue: "zgrada", rusValue: "здание")
            CardFlipHero(number: 6, srbValue: "novogradnja", rusValue: "новостройка")
            CardFlipHero(number: 7, srbValue: "vikendica", rusValue: "дача")
            CardFlipHero(number: 8, srbValue: "nekretnina", rusValue: "недвижимость")
            CardFlipHero(number: 9, srbValue: "kuća", rusValue: "дом")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
