class MerchandiseItem {
  final int id;
  final int idTipe;
  final int idKategori;
  final String code;
  final String judul;
  final String deskripsi;
  final String gambar;
  final String redirectLink;
  final String linkNoPayment;
  final int ctaBtn;
  final int status;
  final DateTime createdDate;

  MerchandiseItem({
    required this.id,
    required this.idTipe,
    required this.idKategori,
    required this.code,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
    required this.redirectLink,
    required this.linkNoPayment,
    required this.ctaBtn,
    required this.status,
    required this.createdDate,
  });

  factory MerchandiseItem.fromJson(Map<String, dynamic> json) {
    return MerchandiseItem(
      id: json["id"],
      idTipe: json["id_merchandise_tipe"],
      idKategori: json["id_merchandise_kategori"],
      code: json["code"] ?? "",
      judul: json["judul"] ?? "",
      deskripsi: json["deskripsi"] ?? "",
      gambar: json["gambar"] ?? "",
      redirectLink: json["redirect_link"] ?? "",
      linkNoPayment: json["link_no_payment"] ?? "",
      ctaBtn: json["cta_btn"] ?? 0,
      status: json["status"] ?? 0,
      createdDate: DateTime.parse(json["created_date"]),
    );
  }
}
