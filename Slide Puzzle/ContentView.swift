//
//  ContentView.swift
//  Slide Puzzle
//
//  Created by Mind Nichapa on 1/11/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameModel: GameModel
    
    @State var winned = false
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let sizeBox = screenSize.width/4
        let primary_color = Color.black/*Color(red: 252/255, green: 67/255, blue: 89/255)*/
        let backgroundGradient = LinearGradient(
            colors: [Color(red: 238/255, green:174/255, blue: 200/255), Color(red: 148/255, green:187/255, blue: 200/255)],
            startPoint: .top, endPoint: .bottom)
        
        VStack{
            
            Text("Slide Puzzle")
                .font(.system(size: 55))
                .padding(.horizontal).bold()
                .foregroundColor(primary_color)
            
            VStack (spacing: 5){
                ForEach(0..<4, id: \.self){row in
                    HStack(spacing: 5){
                        ForEach(0..<4, id: \.self){column in
                            CardView(content: gameModel.numbers[row * 4 + column])
                                .frame(maxWidth: .infinity, maxHeight: sizeBox)
                                .foregroundColor(primary_color)
                            
                                .onTapGesture {
                                    if(!winned){
                                        gameModel.moveNumber(indexNumber: row * 4 + column)
                                        self.winned = gameModel.checkWiner()
                                        print(winned)
                                        
                                    }
                                    
                                }
                                .animation(.default, value :gameModel.numbers)
                        }
                    }
                }.padding(7)
                
            }
            
            //result
            Spacer()
            Winer(win: winned)
            //Move
            Spacer()
            
            Counter(Count: gameModel.moveCount)
            Spacer()
            
            Button("New Game")  {
                gameModel.restart()
            }
            .font(.system(size: 30))
            .foregroundColor(.white)
//            .background(winned ? Color.gray.opacity(0.5) : Color.white)
            .cornerRadius(100)
            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(winned ? .white : Color.clear , lineWidth: 2)
            )
            
        }.background(backgroundGradient)
    }
    
    
    
    
}


struct CardView: View {
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.foregroundColor(content.isEmpty ? .white.opacity(0): .white.opacity(0.5))
            //base.strokeBorder(lineWidth: content.isEmpty ? 0: 2)
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
                .font(.custom("Adelle Sans Devanagari Bold", fixedSize: 10))
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
