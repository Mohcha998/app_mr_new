import 'package:flutter/material.dart';
import '../home/widgets/home_news_section.dart';

class QuotesGalleryPage extends StatefulWidget {
  const QuotesGalleryPage({super.key});

  @override
  State<QuotesGalleryPage> createState() => _QuotesGalleryPageState();
}

class _QuotesGalleryPageState extends State<QuotesGalleryPage> {
  List<String> categories = [
    "Love",
    "Family",
    "Dream",
    "Hope",
    "Grateful",
    "Indonesia",
    "Joy",
  ];

  String selectedCategory = "Love";

  List<String> quoteImages = [
    "https://merryriana.com/server_api/asset/quotes/1.jpg",
    "https://merryriana.com/server_api/asset/quotes/2.jpg",
    "https://merryriana.com/server_api/asset/quotes/3.jpg",
    "https://merryriana.com/server_api/asset/quotes/4.jpg",
    "https://merryriana.com/server_api/asset/quotes/1.jpg",
    "https://merryriana.com/server_api/asset/quotes/2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final displayQuotes = quoteImages.take(4).toList();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Quotes",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // ================= Categories =================
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: categories.length,
                itemBuilder: (context, i) {
                  final c = categories[i];
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedCategory = c);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == c
                            ? Colors.orange.shade400
                            : const Color(0xFFB92D24),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          c,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // =================== QUOTES SECTION WRAPPER ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // GRID INSIDE WHITE CARD
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayQuotes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              displayQuotes[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // SHOW MORE inside the card
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9D9D9),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Show More",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ============= Home News Section (dipisah) =============
            // const HomeNewsSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
