class AdsPopupModel {
  final int id;
  final String title;
  final String imageUrl;
  final String linkUrl;
  final String fabImageUrl;
  final int status;
  final String dateCreated;

  AdsPopupModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    required this.fabImageUrl,
    required this.status,
    required this.dateCreated,
  });

  factory AdsPopupModel.fromJson(Map<String, dynamic> json) {
    return AdsPopupModel(
      id: json["id"],
      title: json["title"],
      imageUrl: json["image_url"],
      linkUrl: json["link_url"],
      fabImageUrl: json["fab_image_url"],
      status: json["status"],
      dateCreated: json["date_created"],
    );
  }
}
