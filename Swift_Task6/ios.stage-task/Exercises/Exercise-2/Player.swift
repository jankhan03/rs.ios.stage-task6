//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//


import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand : [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        
        if hand != nil {
            for cardInHand in hand! {
                if cardInHand.value == card.value {
                    return true
                }
            }
        }
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        
            for cardInHand in hand! {
                for cardOnTable in table {

                    if cardInHand.value == cardOnTable.value.value{
                        return true
                    }
                    if cardInHand.value == cardOnTable.key.value{
                        return true
                    }
                    
                }
            }
        
        
        
        return false
    }
}
