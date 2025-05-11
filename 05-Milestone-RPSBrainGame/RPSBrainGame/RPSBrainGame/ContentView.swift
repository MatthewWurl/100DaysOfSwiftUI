//
//  ContentView.swift
//  RPSBrainGame
//
//  Created by Matt X on 1/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice: GameChoice = [.rock, .paper, .scissors].randomElement()!
    
    @State private var expectedOutcome: GameOutcome = [.win, .lose].randomElement()!
    @State private var isPlayerCorrect: Bool = true
    
    @State private var currentQuestion = 1
    @State private var score = 0
    @State private var scoreTitle = ""
    
    @State private var isShowingScore = false
    @State private var isShowingGameOver = false
    
    let gameChoices: [GameChoice] = [.rock, .paper, .scissors]
    let gameOutcomes: [GameOutcome] = [.win, .tie, .lose]
    
    let questionAmount = 10
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BG-1"), Color("BG-2")],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                Text("RPS Brain Game")
                    .font(.largeTitle.bold())
                
                Text("Question: \(currentQuestion)/\(questionAmount)")
                    .font(.title2)
                
                VStack(spacing: 40) {
                    VStack {
                        Text("AI Picks: \(appChoice.description)")
                        
                        HStack {
                            Text("Your goal is to:")
                            
                            Text(expectedOutcome.description)
                                .foregroundStyle(expectedOutcome == .win ? .green : .red)
                        }
                    }
                    .font(.title)
                    
                    HStack(spacing: 30) {
                        ForEach(gameChoices, id: \.self) { gameChoice in
                            Button {
                                choiceTapped(gameChoice)
                            } label: {
                                Text(gameChoice.description)
                                    .font(.system(size: 60))
                            }
                        }
                    }
                    .alert(scoreTitle, isPresented: $isShowingScore) {
                        Button("Continue", action: nextScenario)
                    } message: {
                        isPlayerCorrect ? (
                            Text("Correct, +1! Your score is now \(score).")
                        ) : (
                            Text("Incorrect, -1! Your score is now \(score).")
                        )
                    }
                }
                .padding(.vertical, 60)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .alert("Game over!", isPresented: $isShowingGameOver) {
                        Button("Play again", action: resetGame)
                    } message: {
                        Text("Your final score is \(score).")
                    }
            }
            .foregroundStyle(.primary)
            .padding()
        }
    }
    
    func choiceTapped(_ playerChoice: GameChoice) {
        var actualOutcome: GameOutcome
        
        switch (playerChoice, appChoice) {
            // Winning scenarios
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            actualOutcome = .win
            // Tying scenarios
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            actualOutcome = .tie
            // Losing scenarios
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            actualOutcome = .lose
        }
        
        isPlayerCorrect = expectedOutcome == actualOutcome
        scoreTitle = expectedOutcome == actualOutcome ? "Correct!" : "Incorrect!"
        score = expectedOutcome == actualOutcome ? score + 1 : score - 1
        
        isShowingScore = true
    }
    
    func nextScenario() {
        if currentQuestion != questionAmount {
            appChoice = gameChoices.randomElement()!
            expectedOutcome = [.win, .lose].randomElement()!
            
            currentQuestion += 1
        } else {
            isShowingGameOver = true
        }
    }
    
    func resetGame() {
        currentQuestion = 1
        score = 0
    }
}

enum GameChoice: String, CaseIterable {
    case rock = "🪨"
    case paper = "📄"
    case scissors = "✂️"
    
    var description: String {
        self.rawValue
    }
}

enum GameOutcome: String {
    case win = "Win"
    case tie = "Tie"
    case lose = "Lose"
    
    var description: String {
        self.rawValue
    }
}

#Preview {
    ContentView()
}
