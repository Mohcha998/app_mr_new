import 'merchandise_item.dart';

class MerchandiseByType {
  final int idKategori;
  final String kategoriNama;
  final List<MerchandiseItem> merchandise;

  MerchandiseByType({
    required this.idKategori,
    required this.kategoriNama,
    required this.merchandise,
  });

  factory MerchandiseByType.fromJson(Map<String, dynamic> json) {
    return MerchandiseByType(
      idKategori: json["id_merchandise_kategori"] ?? 0,
      kategoriNama: json["name_merchandise_kategori"] ?? "",
      merchandise: (json["merchandise"] as List)
          .map((e) => MerchandiseItem.fromJson(e))
          .toList(),
    );
  }
}
