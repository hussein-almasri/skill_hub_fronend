import '../../domain/entities/challenge.dart';

class ChallengeModel extends Challenge {

  ChallengeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.difficulty,
    required super.points,
    required super.category,
    required super.solvedCount,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {

    return ChallengeModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      difficulty: json["difficulty"],
      points: json["points"],
      category: json["category"],
      solvedCount: json["solved_count"] ?? 0,
    );

  }

}