import 'package:flutter/material.dart';
import '../../../services/merchandise_service.dart';
import '../../../models/merchandise_by_type.dart';
import '../../../models/merchandise_item.dart';
import '../category_detail/category_detail_page.dart';
import 'category_group.dart';

class CategorySection extends StatefulWidget {
  final String searchKeyword;

  const CategorySection({super.key, required this.searchKeyword});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final merchandiseService = MerchandiseService();

  MerchandiseByType? books;
  MerchandiseByType? fashion;
  MerchandiseByType? others;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final byBooks = await merchandiseService.getByTipe(1);
      final byFashion = await merchandiseService.getByTipe(2);
      final byOthers = await merchandiseService.getByTipe(4);

      setState(() {
        books = byBooks.isNotEmpty ? byBooks.first : null;
        fashion = byFashion.isNotEmpty ? byFashion.first : null;
        others = byOthers.isNotEmpty ? byOthers.first : null;
        loading = false;
      });
    } catch (_) {
      loading = false;
    }
  }

  /// ===============================
  /// FILTER PRODUCT BY SEARCH
  /// ===============================
  List<MerchandiseItem> _filter(List<MerchandiseItem> items) {
    if (widget.searchKeyword.isEmpty) return items;

    final keyword = widget.searchKeyword.toLowerCase();

    return items
        .where(
          (MerchandiseItem item) => item.judul.toLowerCase().contains(keyword),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (MediaQuery.of(context).size.width - 60) / 2;

    if (loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final List<MerchandiseItem> filteredBooks = books == null
        ? []
        : _filter(books!.merchandise);

    final List<MerchandiseItem> filteredFashion = fashion == null
        ? []
        : _filter(fashion!.merchandise);

    final List<MerchandiseItem> filteredOthers = others == null
        ? []
        : _filter(others!.merchandise);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==============================
          // TITLE + SEE ALL
          // ==============================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              GestureDetector(
                onTap: () async {
                  final List<MerchandiseItem> allProducts =
                      await merchandiseService.getAllFlat();

                  final List<MerchandiseItem> filteredAll = _filter(
                    allProducts,
                  );

                  if (!mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryDetailPage(
                        title: widget.searchKeyword.isEmpty
                            ? "All Merchandise"
                            : "Search Result",
                        products: filteredAll,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, color: Colors.red),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ==============================
          // CATEGORY GROUPS (FILTERED)
          // ==============================
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              if (filteredBooks.isNotEmpty)
                CategoryGroup(
                  title: books!.kategoriNama,
                  count: filteredBooks.length,
                  images: filteredBooks.map((e) => e.gambar).take(4).toList(),
                  width: itemWidth,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryDetailPage(
                          title: books!.kategoriNama,
                          products: filteredBooks,
                        ),
                      ),
                    );
                  },
                ),

              if (filteredFashion.isNotEmpty)
                CategoryGroup(
                  title: fashion!.kategoriNama,
                  count: filteredFashion.length,
                  images: filteredFashion.map((e) => e.gambar).take(4).toList(),
                  width: itemWidth,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryDetailPage(
                          title: fashion!.kategoriNama,
                          products: filteredFashion,
                        ),
                      ),
                    );
                  },
                ),

              if (filteredOthers.isNotEmpty)
                CategoryGroup(
                  title: others!.kategoriNama,
                  count: filteredOthers.length,
                  images: filteredOthers.map((e) => e.gambar).take(4).toList(),
                  width: itemWidth,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryDetailPage(
                          title: others!.kategoriNama,
                          products: filteredOthers,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),

          if (filteredBooks.isEmpty &&
              filteredFashion.isEmpty &&
              filteredOthers.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  "Produk tidak ditemukan",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
