import '../../domain/entities/leaderboard_user.dart';

class LeaderboardUserModel extends LeaderboardUser {

  LeaderboardUserModel({
    required super.username,
    required super.points,
  });

  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {

    return LeaderboardUserModel(
      username: json["username"],
      points: json["points"],
    );

  }

}