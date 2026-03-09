class UserStatsModel {

  final String username;
  final String email;
  final int points;
  final int solvedChallenges;

  UserStatsModel({
    required this.username,
    required this.email,
    required this.points,
    required this.solvedChallenges,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      username: json["username"],
      email: json["email"],
      points: json["points"],
      solvedChallenges: json["solved_challenges"],
    );
  }
}