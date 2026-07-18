class SurahDetailsModel {
  final String index;
  final String name;
  final Map<String, dynamic> verses;
  final int count;

  SurahDetailsModel({
    required this.index,
    required this.name,
    required this.verses,
    required this.count,
  });

  factory SurahDetailsModel.fromJson(Map<String, dynamic> json) {
    return SurahDetailsModel(
      index: json["index"],
      name: json["name"],
      verses: json["verse"],
      count: json["count"],
    );
  }

  Object? get first => null;
}