class HintModel {

  final int id;
  final String? hintText;
  final int cost;
  final bool unlocked;

  HintModel({
    required this.id,
    this.hintText,
    required this.cost,
    required this.unlocked,
  });

  factory HintModel.fromJson(Map<String, dynamic> json) {

    return HintModel(
      id: json["id"],
      hintText: json["hint_text"],
      cost: json["cost"],
      unlocked: json["unlocked"] ?? false,
    );

  }

}