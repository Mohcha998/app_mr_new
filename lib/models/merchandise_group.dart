import 'merchandise_item.dart';

class MerchandiseGroup {
  final String id;
  final String typeName;
  final List<MerchandiseItem> products;

  MerchandiseGroup({
    required this.id,
    required this.typeName,
    required this.products,
  });

  factory MerchandiseGroup.fromJson(Map<String, dynamic> json) {
    return MerchandiseGroup(
      id: json["id"].toString(),
      typeName: json["name_merchandise_tipe"] ?? "",
      products: (json["merchandise"] as List)
          .map((e) => MerchandiseItem.fromJson(e))
          .toList(),
    );
  }
}
