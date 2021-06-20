import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        let suits = Suit.allCases
        let values = Value.allCases
        cards = createDeck(suits: suits, values: values)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {

        var deskCards = [Card]()
        
        for suit in suits {
            for value in values {
                deskCards.append(Card(suit: suit, value: value))
            }
        }
        return deskCards
    }

    public mutating func shuffle() {
        var tempCards = cards
        
        while let card = tempCards.randomElement() {
            cards.append(card)
            let i = tempCards.firstIndex(of: card)!
            tempCards.remove(at: i)
        }
    }

    public mutating func defineTrump() {
        trump = cards.first?.suit
        setTrumpCards(for: trump!)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {

        if players.count < 7 {
            for player in players {
                var tmp = [Card]()
                for index in 0 ..< 6 {
                    tmp.append(cards[index])
                }
                player.hand = tmp
                cards.removeFirst(6)
            }
        }
        

    }

    public mutating func setTrumpCards(for suit:Suit) {
        
        for (index, card) in cards.enumerated() {
            if card.suit == suit {
                cards[index].isTrump = true
            }
        }
    }
}
