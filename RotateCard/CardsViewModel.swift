//
//  CardsViewModel.swift
//  RotateCard
//
//  Created by Alexander Plotnikov on 19.02.2024.
//

import Foundation

class Card : Identifiable, Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rusValue == rhs.rusValue &&
        lhs.srbValue == rhs.srbValue
    }
    
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
 
    var srbValue: String
    var rusValue: String
    
    init(srbValue: String, rusValue: String) {
        self.srbValue = srbValue
        self.rusValue = rusValue
    }
    
}

class CardsViewModel: ObservableObject {
    
    //let cardsArray: [Card]
    
    init() {
        //self.cardsArray = getData()
    }
    
    
    func getData() -> [Card] {
        var array: [Card] = []
        
        array.append(Card(srbValue: "nameštaj", rusValue: "мебель"))
        array.append(Card(srbValue: "stan", rusValue: "квартира"))
        array.append(Card(srbValue: "soba", rusValue: "комната"))
        array.append(Card(srbValue: "sprat", rusValue: "этаж"))
        array.append(Card(srbValue: "zgrada", rusValue: "здание"))
        array.append(Card(srbValue: "novogradnja", rusValue: "новостройка"))
        array.append(Card(srbValue: "vikendica", rusValue: "дача"))
        array.append(Card(srbValue: "nekretnina", rusValue: "недвижимость"))
        array.append(Card(srbValue: "kuća", rusValue: "дом"))
        
        return array
    }
    

}
