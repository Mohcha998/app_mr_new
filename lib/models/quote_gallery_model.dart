class QuoteGallery {
  final int id;
  final String category;
  final String images;
  final String createdAt;

  QuoteGallery({
    required this.id,
    required this.category,
    required this.images,
    required this.createdAt,
  });

  factory QuoteGallery.fromJson(Map<String, dynamic> json) {
    return QuoteGallery(
      id: json["id"],
      category: json["category"],
      images: json["images"],
      createdAt: json["created_at"],
    );
  }
}
