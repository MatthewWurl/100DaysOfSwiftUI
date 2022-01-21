//
//  ContentView.swift
//  RockPaperScissorsBrainGame
//
//  Created by Matt X on 1/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice: GameChoice = [.Rock, .Paper, .Scissors].randomElement()!
    
    @State private var expectedOutcome: GameOutcome = [.Win, .Lose].randomElement()!
    @State private var isPlayerCorrect: Bool = true
    
    @State private var currentQuestion = 1
    @State private var score = 0
    @State private var scoreTitle = ""
    
    @State private var isShowingScore = false
    @State private var isShowingGameOver = false
    
    let gameChoices: [GameChoice] = [.Rock, .Paper, .Scissors]
    let gameOutcomes: [GameOutcome] = [.Win, .Tie, .Lose]
    
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
                                .foregroundColor(expectedOutcome == .Win ? .green : .red)
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
            .foregroundColor(.primary)
            .padding()
        }
    }
    
    func choiceTapped(_ playerChoice: GameChoice) {
        var actualOutcome: GameOutcome
        
        switch (playerChoice, appChoice) {
            // Winning scenarios
        case (.Rock, .Scissors), (.Paper, .Rock), (.Scissors, .Paper):
            actualOutcome = .Win
            // Tying scenarios
        case (.Rock, .Rock), (.Paper, .Paper), (.Scissors, .Scissors):
            actualOutcome = .Tie
            // Losing scenarios
        case (.Rock, .Paper), (.Paper, .Scissors), (.Scissors, .Rock):
            actualOutcome = .Lose
        }
        
        isPlayerCorrect = expectedOutcome == actualOutcome
        scoreTitle = expectedOutcome == actualOutcome ? "Correct!" : "Incorrect!"
        score = expectedOutcome == actualOutcome ? score + 1 : score - 1
        
        isShowingScore = true
    }
    
    func nextScenario() {
        if currentQuestion != questionAmount {
            appChoice = gameChoices.randomElement()!
            expectedOutcome = [.Win, .Lose].randomElement()!
            
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
    case Rock = "🪨"
    case Paper = "📄"
    case Scissors = "✂️"
    
    var description: String {
        self.rawValue
    }
}

enum GameOutcome: String {
    case Win = "Win"
    case Tie = "Tie"
    case Lose = "Lose"
    
    var description: String {
        self.rawValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
