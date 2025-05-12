//
//  ContentView.swift
//  WordScramble
//
//  Created by Matt X on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isShowingError = false
    
    let wordLengthValues = [
        8 : 4000,
        7 : 2500,
        6 : 1600,
        5 : 900,
        4 : 400,
        3 : 100
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                    
                    HStack {
                        Text("Your current score is:")
                        Spacer()
                        Text("\(score)")
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                            Spacer()
                            Text("+\(wordLengthValues[word.count] ?? 0)")
                        }
                        // Project 15 challenge
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                        .foregroundStyle(word.count == 8 ? .green : .primary)
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $isShowingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        startGame()
                    } label: {
                        Text("New Word")
                    }
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer != rootWord else {
            wordError(
                title: "Word cannot be the root word",
                message: "Sorry, try something else!"
            )
            return
        }
        
        guard answer.count >= 3 else {
            wordError(
                title: "Word must be at least 3 letters",
                message: "Sorry, that word is too short!"
            )
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(
                title: "Word used already",
                message: "Be more original!"
            )
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }
        
        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, you know!"
            )
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += wordLengthValues[answer.count] ?? 0
        
        newWord = ""
    }
    
    func startGame() {
        guard let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        )
        else {
            fatalError("Could not load start.txt from bundle.")
        }
        
        guard let startWords = try? String(
            contentsOf: startWordsURL,
            encoding: .utf8
        )
        else {
            fatalError("Could not convert contents of start.txt to String.")
        }
        
        let allWords = startWords.components(separatedBy: .newlines)
        
        rootWord = allWords.randomElement() ?? "silkworm"
        
        // Reset score and used words
        score = 0
        usedWords = []
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            guard let pos = tempWord.firstIndex(of: letter)
            else { return false }
            
            tempWord.remove(at: pos)
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        isShowingError = true
    }
}

#Preview {
    ContentView()
}
