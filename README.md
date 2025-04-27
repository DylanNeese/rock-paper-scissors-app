# rock-paper-scissors-app

CS 386 Final Project
Dylan Neese

Instruction
	The Flutter app I made is a simple Rock, Paper, Scissors game in which you play versus a computer. To determine a winner, you play best 3 out of 5 games. The players make their choice by selecting one of the 3 options and the CPU selects a random choice. The app keeps track of the score and displays the results. It also shaves the progress of the game using shared preferences.
	The target user of the game is anyone who is looking for something to waste time with that is fun. It’s a simple flutter program that can guide beginners in Flutter learn about UI design, management and persistent storage.

 
Design and Architecture
UI layer: GameScreen is the main widget that builds the user interface 
Model: GameModel defines the game data structure. Including User and CPU choice and results + scores. 
Persistence Layer: Shared Preferences are used  in order to save and load the state of game locally as a JSON string. 
# GameModel Class Diagram

classDiagram
  class GameModel {
    - String userChoice
    - String computerChoice
    - String result
    - int userScore
    - int cpuScore
    + GameModel() 
    + Map<String, dynamic> toJson()
    + static GameModel fromJson(Map<String, dynamic> json)
  }


Instructions
First you need install flutter and set up an emulator. Your need to copy this project and put them in a flutter project folder to run. You will need to make sure you have VS Code and run the project through that. To get the app started you need to press the play button or flutter run in the terminal. 
	How you play is pretty simple. You will see 3 emojis that are rock, paper, and scissors. You must select one of them  and the CPU will automatically select a choice. You will either win or lose the round and in order to win the game you must win 3 rounds. To restart you select the restart button
To test it I just opened the app and selected the same choice over and over to insure the computer was random.  I made sure it was 3 wins in order to win the game. I also closed and reopened the app to insure it saved your current game.


Challenges, Role of AI, Insights
Some of the challenges I faced was really Just learning Flutter and dart. Understanding what does what and how to do certain things. I would say trying to get only emojis to appear instead or names was difficult and making it properly saved data and using the shared preferences. Making sure the game over worked correctly and restarted the app.
AI was a huge help in my pocket. It genuinely taught me how to do the code and how to do specific things. I would ask it how to do certain things or “can I do this?” and It would guide me to do it. Without AI this project would have been 10 times harder. 
Some things I learned was how to make a clean looking interface and understanding how flutter manages different widget states and user inputs. I learned how to work with a local data storage that is simple within the flutter app. 


Next Steps
If I had more time on this, I would have figures out how to create a two-player game where I could play with two different people on two devices. In addition to that adding difficulties to the game would be cool to have made too. Match history and overall records would be nice to do as well. I would have liked to explore more into the interface and how to make it look more professional instead of like a little project. 


![image](https://github.com/user-attachments/assets/18d7582e-b444-4e58-8d3b-035dd4e25d0d)
