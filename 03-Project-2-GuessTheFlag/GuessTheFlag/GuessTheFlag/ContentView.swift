//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matt X on 1/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingScore = false
    @State private var isShowingGameOver = false
    
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var currentQuestion = 1
    @State private var selectedAnswer = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    let questionAmount = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Text("Current question: \(currentQuestion)/\(questionAmount)")
                    .font(.title2)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $isShowingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    scoreTitle == "Correct!" ? (
                        Text("Your score is now \(score)/\(questionAmount).")
                    ) : (
                        Text("Sorry, that's the flag of \(countries[selectedAnswer])!")
                    )
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)/\(questionAmount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .alert("Game over!", isPresented: $isShowingGameOver) {
                        Button("Play again", action: resetGame)
                    } message: {
                        Text("Your final score is \(score)/\(questionAmount).")
                    }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        scoreTitle = number == correctAnswer ? "Correct!" : "Incorrect!"
        score = number == correctAnswer ? score + 1 : score
        
        selectedAnswer = number
        
        isShowingScore = true
    }
    
    func askQuestion() {
        if currentQuestion == questionAmount {
            isShowingGameOver = true
        } else {
            currentQuestion += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func resetGame() {
        currentQuestion = 1
        score = 0
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}