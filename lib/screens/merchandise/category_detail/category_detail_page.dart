// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../models/merchandise_item.dart';

class CategoryDetailPage extends StatefulWidget {
  final String title;
  final List<MerchandiseItem> products;

  const CategoryDetailPage({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late List<MerchandiseItem> filteredProducts;
  final TextEditingController _searchController = TextEditingController();

  String formatRupiah(num value) {
    final format = NumberFormat.decimalPattern('id_ID');
    return format.format(value);
  }

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void _onSearch(String keyword) {
    setState(() {
      filteredProducts = widget.products.where((p) {
        final title = p.judul.toLowerCase();
        final query = keyword.toLowerCase();
        return title.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// ================= SEARCH FIELD =================
              TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: "Cari produk...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// ================= PRODUCT GRID =================
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 310,
                ),
                itemBuilder: (context, index) {
                  final p = filteredProducts[index];

                  return GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(p.redirectLink);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },

                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: 165,
                              width: double.infinity,
                              child: Image.network(
                                p.gambar,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Icon(Icons.broken_image),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// TEXT + PRICE
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  p.judul,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (p.hargaCoret > 0)
                                      Text(
                                        "Rp ${formatRupiah(p.hargaCoret)}",
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 11,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    const SizedBox(height: 2),
                                    if (p.harga > 0)
                                      Text(
                                        "Rp ${formatRupiah(p.harga)}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              if (filteredProducts.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      "Produk tidak ditemukan",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
