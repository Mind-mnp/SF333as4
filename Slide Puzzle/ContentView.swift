//
//  ContentView.swift
//  Slide Puzzle
//
//  Created by Mind Nichapa on 1/11/2566 BE.
//

import SwiftUI

struct ContentView: View {
    var gameModel: GameModel
    @State private var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "","15"]
    @State private var numbersWin = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",""]
    
    
    @State var cardCount = 15
    @State var count = 0
    @State var winned = false
    
    
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let sizeBox = screenSize.width/4
        let primary_color = Color(red: 252/255, green: 67/255, blue: 89/255)
        
        Text("Slide Puzzle")
            .font(.system(size: 50))
        //.padding(.horizontal).bold()
            .foregroundColor(primary_color)
        
        
        VStack (spacing: 5){
            ForEach(0..<4, id: \.self){row in
                HStack(spacing: 5){
                    ForEach(0..<4, id: \.self){column in
                        CardView(content: numbers[row * 4 + column])
                            .frame(maxWidth: .infinity, maxHeight: sizeBox)
                            .foregroundColor(primary_color)
                            .onTapGesture {
                                if(!winned){
                                    self.moveNumber(indexNumber: row * 4 + column)
                                    self.winned = checkWiner()
                                }
                                
                            }
                            .animation(.default, value :numbers)
                    }
                }
            }.padding(3)
            
        }
        
        //result
        Spacer()
        Winer(win: winned)
        //Move
        Spacer()
        Counter(Count: count)
        Spacer()
        Button("New Game")  {
            print("restart")
            gameModel.restart()
            self.newGame()
        }
        .font(.system(size: 30))
        .foregroundColor(.gray)
        //.frame(width: 50, height: 100)
        //.border(Color.black, width: 2)
        
    }
    //move
    func moveNumber(indexNumber: Int) {
        //เลื่อนบน
        if let top = indexNumber < 4 ?  nil : indexNumber - 4, numbers[top] == "" {
            print("Top")
            numbers.swapAt(top, indexNumber)
            count += 1
            
        }
        //เลื่อนล่าง
        else if let below = indexNumber > 11 ?  nil : indexNumber + 4, numbers[below] == "" {
            print("Below")
            numbers.swapAt(below, indexNumber)
            self.count+=1
        }
        //เลื่อซ้าย
        else if let left = indexNumber%4 == 0 ?  nil : indexNumber - 1 , numbers[left] == "" {
            print("Left")
            numbers.swapAt(left, indexNumber)
            self.count+=1
        }
        //เลื่อนลง
        else if let right = indexNumber%4 == 3 ?  nil : indexNumber + 1 , numbers[right] == "" {
            print("Right")
            numbers.swapAt(right, indexNumber)
            self.count+=1
        }
    }
    
    func newGame()  {
        count = 0
        numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",""].shuffled()
        winned.toggle()
    }
    
    func checkWiner() -> Bool {
        return numbers.elementsEqual(numbersWin)
    }
    
    
    
    
}


struct CardView: View {
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.foregroundColor(.white)
            base.strokeBorder(lineWidth: content.isEmpty ? 0: 2)
            Text(content).font(.largeTitle)
        }
        
    }
}

struct Winer: View {
    let win: Bool
    
    var body: some View {
        if(win){
            Text("You win🏆")
                .font(.custom("Adelle Sans Devanagari Bold", fixedSize: 30))
                .padding(.horizontal).bold()
                .foregroundColor(.black)
            
        }
        else{
            Text("")
                .font(.custom("Adelle Sans Devanagari Bold", fixedSize: 30))
                .padding(.horizontal).bold()
                .foregroundColor(.black)
        }
        
    }
}




struct Counter: View {
    var Count: Int
    var body: some View {
        Text("Move: " + String(Count))
            .font(.custom("Adelle Sans Devanagari Bold", fixedSize: 30))
            .padding(.horizontal).bold()
            .foregroundColor(.black)
    }
}





#Preview {
    ContentView(gameModel: GameModel())
}
