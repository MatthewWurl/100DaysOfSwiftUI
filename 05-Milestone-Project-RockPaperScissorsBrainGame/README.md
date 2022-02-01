# Milestone Project - Rock-Paper-Scissors Brain Game (Projects 1-3)

>You have a basic understanding of arrays, state, views, images, text, and more, so let’s put them together: your challenge is to make a brain training game that challenges players to win or lose at rock, paper, scissors.
>
>So, very roughly:
>
>* Each turn of the game the app will randomly pick either rock, paper, or scissors.<br>
>* Each turn the app will alternate between prompting the player to win or lose.<br>
>* The player must then tap the correct move to win or lose the game.<br>
>* If they are correct they score a point; otherwise they lose a point.<br>
>* The game ends after 10 questions, at which point their score is shown.<br>
><br>
>So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.

## Challenges

1. Start with an App template, then create a property to store the three possible moves: rock, paper, and scissors.
2. You’ll need to create two `@State` properties to store the app’s current choice and whether the player should win or lose.
3. You can use `Int.random(in:)` to select a random move. You can use it for whether the player should win too if you want, but there’s an even easier choice: `Bool.random()` is randomly true or false. After the initial value, use `toggle()` between rounds so it’s always changing.
4. Create a `VStack` showing the player’s score, the app’s move, and whether the player should win or lose. You can use `if shouldWin` to return one of two different text views.
5. The important part is making three buttons that respond to the player’s move: Rock, Paper, or Scissors.
6. Use the `font()` modifier to adjust the size of your text. If you’re using emoji for the three moves, they also scale. Tip: You can ask for very large system fonts using `.font(.system(size: 200))` – they’ll be a fixed size, but at least you can make sure they are nice and big!

## Screenshots

### Light Mode

<div>
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Light/Milestone%20Project%20-%20Light%201.png" width="250">
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Light/Milestone%20Project%20-%20Light%202.png" width="250">
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Light/Milestone%20Project%20-%20Light%203.png" width="250">
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Light/Milestone%20Project%20-%20Light%204.png" width="250">
</div>

### Dark Mode

<div>
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Dark/Milestone%20Project%20-%20Dark%201.png" width="250">
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Dark/Milestone%20Project%20-%20Dark%202.png" width="250">
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Dark/Milestone%20Project%20-%20Dark%203.png" width="250">
  <img src="https://github.com/AnxietyMedicine/100DaysOfSwiftUI/blob/main/05-Milestone-Project-RockPaperScissorsBrainGame/Screenshots/Dark/Milestone%20Project%20-%20Dark%204.png" width="250">
</div>
