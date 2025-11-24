import 'package:flutter/material.dart';
import '../../../services/merchandise_service.dart';
import '../../../models/merchandise_by_type.dart';
import 'category_group.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

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
      final byBooks = await merchandiseService.getByTipe(1); // Books
      final byFashion = await merchandiseService.getByTipe(2); // Fashion
      final byOthers = await merchandiseService.getByTipe(4); // Others

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
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
            ],
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              // BOOKS
              if (books != null)
                CategoryGroup(
                  title: books!.kategoriNama,
                  count: books!.merchandise.length,
                  images: books!.merchandise
                      .map((item) => item.gambar) // ← gambar API
                      .take(4)
                      .toList(),
                  width: itemWidth,
                ),

              // FASHION
              if (fashion != null)
                CategoryGroup(
                  title: fashion!.kategoriNama,
                  count: fashion!.merchandise.length,
                  images: fashion!.merchandise
                      .map((item) => item.gambar) // ← gambar API
                      .take(4)
                      .toList(),
                  width: itemWidth,
                ),

              // OTHERS
              if (others != null)
                CategoryGroup(
                  title: others!.kategoriNama,
                  count: others!.merchandise.length,
                  images: others!.merchandise
                      .map((item) => item.gambar) // ← gambar API
                      .take(4)
                      .toList(),
                  width: itemWidth,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
