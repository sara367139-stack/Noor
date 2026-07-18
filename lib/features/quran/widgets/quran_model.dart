class QuranSurah {
  final int number;
  final String name;
  final List<String> ayahs;

  QuranSurah({
    required this.number,
    required this.name,
    required this.ayahs,
  });

  factory QuranSurah.fromJson(Map<String, dynamic> json) {
    return QuranSurah(
      number: json["number"],
      name: json["name"],
      ayahs: List<String>.from(json["ayahs"]),
    );
  }
}