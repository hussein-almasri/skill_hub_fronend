class CreateChallengeModel {

  final String title;
  final String description;
  final String difficulty;
  final int points;
  final String category;

  CreateChallengeModel({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.points,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "difficulty": difficulty,
      "points": points,
      "category": category,
    };
  }
}