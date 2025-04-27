// rockpaperscissors.dart
// 4-27-25
// Dylan Neese
// Play RPC with a CPu best 3 out of 5

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'FinalModel.dart';

// Entering the App
void main() {
  runApp(RockPaperScissorsApp());
}
// Root 
class RockPaperScissorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: GameScreen(),
    );
  }
}
// Game Screen widget
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}
// State Class for GameScreen
class _GameScreenState extends State<GameScreen> {
  final List<String> choices = ['Rock', 'Paper', 'Scissors'];
  final Map<String, String> emojiMap = {
    'Rock': '🪨',
    'Paper': '📄',
    'Scissors': '✂️',
  };

  late GameModel gameModel;
  bool _isGameOver = false;
// Start with Empty game model 
  @override
  void initState() {
    super.initState();
    gameModel = GameModel(
      userChoice: '',
      computerChoice: '',
      result: 'Choose your move!',
      userScore: 0,
      cpuScore: 0,
    );
    loadGame(); // This will Load game if already there
  }
// CPU selects a random choice 
  String getRandomChoice() {
    final random = Random();
    return choices[random.nextInt(3)];
  }
// This determines a winner for the round
  String determineWinner(String user, String cpu) {
    if (user == cpu) return 'It\'s a draw!'; // Simple Logic for Game
    if ((user == 'Rock' && cpu == 'Scissors') ||
        (user == 'Paper' && cpu == 'Rock') ||
        (user == 'Scissors' && cpu == 'Paper')) {
      return 'You win this round!';
    }
    return 'Prof. Lehman wins this round!';
  }
// This is called when player selects move
  void playGame(String userPick) {
    if (_isGameOver) return;

    String cpuPick = getRandomChoice();
    String outcome = determineWinner(userPick, cpuPick);

    setState(() {
      // game model updates
      gameModel.userChoice = userPick;
      gameModel.computerChoice = cpuPick;
      gameModel.result = outcome;
// score updates
      if (outcome.contains('You win')) gameModel.userScore++;
      if (outcome.contains('Prof. Lehman wins')) gameModel.cpuScore++;
// check for end of game
      if (gameModel.userScore == 3 || gameModel.cpuScore == 3) {
        _isGameOver = true;
        gameModel.result = gameModel.userScore == 3
            ? '🎉 You won the match!'
            : '💻 Prof. Lehman won the match!';
      }
    });

    saveGame();
  }
// Reset whole game
  void resetGame() {
    setState(() {
      _isGameOver = false;
      gameModel = GameModel(
        userChoice: '',
        computerChoice: '',
        result: 'Choose your move!',
        userScore: 0,
        cpuScore: 0,
      );
    });
    saveGame();
  }
// This Saves game data to a local storage
  Future<void> saveGame() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('savedGame', jsonEncode(gameModel.toJson()));
  }
// This Loads saved data from local 
  Future<void> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('savedGame');
    if (data != null) {
      setState(() {
        gameModel = GameModel.fromJson(jsonDecode(data));
        if (gameModel.userScore == 3 || gameModel.cpuScore == 3) {
          _isGameOver = true;
        }
      });
    }
  }
// Meta.ai helped with ^
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rock Paper Scissors'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // This shows the game result and choice 
                Card(
                  elevation: 4,
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      // message displayed
                      children: [
                        Text(
                          gameModel.result,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        // outputs player choice using emojis
                        Text(
                          'Student: ${emojiMap[gameModel.userChoice] ?? ''}  |  Prof. Lehman: ${emojiMap[gameModel.computerChoice] ?? ''}',
                        // ChatGPT helped with this part
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Scoreboard
                Column(
                  children: [
                    Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Student: ${gameModel.userScore}  |  Prof. Lehman: ${gameModel.cpuScore}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30), // Button for RPC 
                if (!_isGameOver)
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: choices.map((choice) {
                      return ElevatedButton(
                        onPressed: () => playGame(choice), // When Pressed
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                          textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('${emojiMap[choice]}'), // Ony show emoji
                        // Ai helped with this
                      );
                    }).toList(),
                  ),
                SizedBox(height: 30), //Restart Button
                ElevatedButton.icon(
                  onPressed: resetGame,
                  icon: Icon(Icons.refresh),
                  label: Text("Restart Match"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}