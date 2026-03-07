class SubmissionModel {

  final int challengeId;
  final String submittedFlag;

  SubmissionModel({
    required this.challengeId,
    required this.submittedFlag,
  });

  Map<String, dynamic> toJson() {
    return {
      "challenge_id": challengeId,
      "submitted_flag": submittedFlag,
    };
  }
}