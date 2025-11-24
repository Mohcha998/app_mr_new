class ResourceModel {
  final String id;
  final String name;
  final String image;
  final String asset;

  ResourceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.asset,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      asset: json['asset'],
    );
  }
}
