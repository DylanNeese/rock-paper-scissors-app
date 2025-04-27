// FinalModel.dart
class GameModel {
  String userChoice;
  String computerChoice;
  String result;
  int userScore;
  int cpuScore;

  GameModel({
    required this.userChoice,
    required this.computerChoice,
    required this.result,
    required this.userScore,
    required this.cpuScore,
  });

  Map<String, dynamic> toJson() => {
        'userChoice': userChoice,
        'computerChoice': computerChoice,
        'result': result,
        'userScore': userScore,
        'cpuScore': cpuScore,
      };

  static GameModel fromJson(Map<String, dynamic> json) => GameModel(
        userChoice: json['userChoice'] ?? '',
        computerChoice: json['computerChoice'] ?? '',
        result: json['result'] ?? '',
        userScore: json['userScore'] ?? 0,
        cpuScore: json['cpuScore'] ?? 0,
      );
}
