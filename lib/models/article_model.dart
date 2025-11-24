class Article {
  final String title;
  final String image;
  final DateTime createdAt;

  Article({required this.title, required this.image, required this.createdAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // ➕ Tambahkan ini
  String get formattedDate {
    return "${createdAt.day}/${createdAt.month}/${createdAt.year}";
  }
}
