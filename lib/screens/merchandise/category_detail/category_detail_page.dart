import 'package:flutter/material.dart';
import '../../../models/merchandise_item.dart';
import '../product_detail/product_detail_page.dart';

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
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEARCH BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 42,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 6),
                  Text("Search Product", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BANNER
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://merryriana.com/server_api/asset/general/banner2.jpeg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // PAGE INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == page ? 22 : 12,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == page ? Colors.red : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // CATEGORY TITLE
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // PRODUCT GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.60,
              ),
              itemBuilder: (context, index) {
                final p = widget.products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(id: p.id),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            p.gambar,
                            fit: BoxFit.cover,
                            errorBuilder: (context, e, s) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        p.judul,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 4),

                      // const Text(
                      //   "\$16,00   \$20,00",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
