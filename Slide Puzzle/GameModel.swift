//
//  ContentView.swift
//  Slide Puzzle
//
//  Created by Mind Nichapa on 1/11/2566 BE.
//

import SwiftUI

class GameModel: ObservableObject {
    static var numbersData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "","15"]
    static var numbersWin = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",""]
    @Published  var numbers: [String] = createModel()
    @Published var moveCount = 0
    
    static func createModel() -> [String] {
        return numbersData
    }
    
    func moveNumber(indexNumber: Int) {
        //เลื่อนบน
        if let top = indexNumber < 4 ?  nil : indexNumber - 4, numbers[top] == "" {
            //print("Top")
            numbers.swapAt(top, indexNumber)
            moveCount += 1
            
        }
        //เลื่อนล่าง
        else if let below = indexNumber > 11 ?  nil : indexNumber + 4, numbers[below] == "" {
            //print("Below")
            numbers.swapAt(below, indexNumber)
            self.moveCount+=1
        }
        //เลื่อซ้าย
        else if let left = indexNumber%4 == 0 ?  nil : indexNumber - 1 , numbers[left] == "" {
            //print("Left")
            numbers.swapAt(left, indexNumber)
            self.moveCount+=1
        }
        //เลื่อนลง
        else if let right = indexNumber%4 == 3 ?  nil : indexNumber + 1 , numbers[right] == "" {
            //print("Right")
            numbers.swapAt(right, indexNumber)
            self.moveCount+=1
        }
        self.objectWillChange.send()
    }
    
    func restart() {
        numbers = GameModel.createModel()
        moveCount = 0
    }
    
    func checkWiner() -> Bool {
        return numbers.elementsEqual(GameModel.numbersWin)
    }
}
