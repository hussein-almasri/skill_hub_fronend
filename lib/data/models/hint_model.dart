class HintModel {

  final int id;
  final String hintText;
  final int cost;

  HintModel({
    required this.id,
    required this.hintText,
    required this.cost,
  });

  factory HintModel.fromJson(Map<String, dynamic> json) {
    return HintModel(
      id: json["id"],
      hintText: json["hint_text"],
      cost: json["cost"],
    );
  }
}