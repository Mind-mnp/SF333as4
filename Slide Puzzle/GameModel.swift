import SwiftUI

class GameModel: ObservableObject {
    static var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",""]
    @Published private var numbers: [String] = createModel()
    @Published var moveCount = 0

    static func createModel() -> [String] {
        return numbers.shuffled()
    }

    func moveNumber(row: Int, column: Int, number : [String]) {
        let index = row * 4 + column
        var numbers = number
        print(numbers)
        if let above = index < 4 ? nil : index - 4, numbers[above] == "0" {
            numbers.swapAt(above, index)
            moveCount += 1
            print("OK")
        } else if let below = index > 11 ? nil : index + 4, numbers[below] == "0" {
            numbers.swapAt(below, index)
            moveCount += 1
            print("OK")
        } else if let left = column == 0 ? nil : index - 1, numbers[left] == "0" {
            numbers.swapAt(left, index)
            moveCount += 1
            print("OK")
        } else if let right = column == 3 ? nil : index + 1, numbers[right] == "0" {
            numbers.swapAt(right, index)
            moveCount += 1
            print("OK")
        }
    }

    func restart() {
        numbers = GameModel.createModel()
        moveCount = 0
        print("OK")
    }
}
