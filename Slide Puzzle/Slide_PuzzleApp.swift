//
//  Slide_PuzzleApp.swift
//  Slide Puzzle
//
//  Created by Mind Nichapa on 1/11/2566 BE.
//

import SwiftUI

@main
struct Slide_PuzzleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: GameModel())
        }
    }
}
