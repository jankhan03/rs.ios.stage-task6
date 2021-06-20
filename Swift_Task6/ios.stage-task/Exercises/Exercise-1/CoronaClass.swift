import Foundation

class CoronaClass {

    var desks: [Int] = []
    var seats = [Int]() { didSet { seats.sort() } }

     init(n: Int) {
        if n > 0 {
            for desk in 0..<n {
                desks.append(desk)
            }
        }
     }

     func seat() -> Int {
        if seats.isEmpty {
            seats.append(0)
            return 0
        } else {
            var max = 0
            var possible = [Int]()
            for desk in desks {
                if !seats.contains(desk) {
                    possible.append(findDistanceFromOccupied(desk: desk))
                    if max < possible.last! {
                        max = possible.last!
                    }
                } else {
                    possible.append(0)
                }
            }
            let place = possible.firstIndex(of: max)!
            seats.append(place)
            return place
        }
     }
    
    func leave(_ p: Int) {
        guard seats.contains(p) else { return }
        seats.remove(at: seats.firstIndex(of: p)!)
    }
    
    func findDistanceFromOccupied(desk:Int) -> Int {
        var dist = (left:0, right:0)
        var newDesk = desk
        while newDesk != -1 {
            newDesk -= 1
            if seats.contains(newDesk) {
                dist.left = abs(desks.distance(from: desk, to: newDesk))
                newDesk = 0
            }
        }
        newDesk = desk
        while newDesk != desks.count {
            newDesk += 1
            if seats.contains(newDesk) {
                dist.right = abs(desks.distance(from: desk, to: newDesk))
                newDesk = desks.count
            }
        }
        switch dist {
            case (_, 0):
                return dist.left
            case (0, _):
                return dist.right
            default:
                return min(dist.left, dist.right)
        }
    }
}
