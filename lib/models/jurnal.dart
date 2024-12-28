class Jurnal {
  final int id;
  final String title;
  final String description;

  Jurnal({required this.id, required this.title, required this.description});

  factory Jurnal.fromJson(Map<String, dynamic> json) {
    return Jurnal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
