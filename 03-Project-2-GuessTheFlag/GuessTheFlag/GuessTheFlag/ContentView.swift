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
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland",
        "Italy", "Nigeria", "Poland", "Russia",
        "Spain", "UK", "US"
    ].shuffled()
    @State private var currentQuestion = 1
    @State private var selectedAnswer = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    // Project 6 challenge variables
    @State private var isAnimatingOpacity = false
    @State private var rotationAmount = 0.0
    @State private var scaleAmount: CGFloat = 1.0
    
    // Project 15 addition
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    let questionAmount = 8
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Guess the Flag")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Current question: \(currentQuestion)/\(questionAmount)")
                .font(.title2)
                .foregroundStyle(.white)
            
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
                        FlagImage(of: countries[number])
                        // Project 15 challenge
                            .accessibilityLabel(
                                labels[countries[number],
                                       default: "Unknown flag"]
                            )
                        // Project 6 challenge
                        // Change opacity of incorrect flags to 0.25
                            .opacity(isAnimatingOpacity ?
                                     (number == correctAnswer ? 1 : 0.25) : 1)
                        // Rotate selected answer 360-degrees on Y-axis
                            .rotation3DEffect(
                                .degrees(number == selectedAnswer ? rotationAmount : 0),
                                axis: (x: 0, y: 1, z: 0))
                        // Scale incorrect answers to 0.5
                            .scaleEffect(
                                number == correctAnswer ? 1 : scaleAmount,
                                anchor: .center)
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
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
                .alert("Game over!", isPresented: $isShowingGameOver) {
                    Button("Play again", action: resetGame)
                } message: {
                    Text("Your final score is \(score)/\(questionAmount).")
                }
            
            Spacer()
        }
        .padding()
        .background(
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
        )
    }
    
    func flagTapped(_ number: Int) {
        scoreTitle = number == correctAnswer ? "Correct!" : "Incorrect!"
        score = number == correctAnswer ? score + 1 : score
        
        selectedAnswer = number
        
        // Project 6 challenge
        withAnimation(.easeInOut) {
            isAnimatingOpacity = true
        }
        
        withAnimation {
            rotationAmount = 360
            scaleAmount = 0.5
        }
        
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
        
        // Project 6 challenge
        isAnimatingOpacity = false
        rotationAmount = 0.0
        scaleAmount = 1.0
    }
    
    func resetGame() {
        currentQuestion = 1
        score = 0
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    let country: String
    
    init(of country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
