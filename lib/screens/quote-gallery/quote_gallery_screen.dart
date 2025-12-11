import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/quote_gallery_service.dart';
import '../../models/quote_gallery_model.dart';

class QuotesGalleryPage extends StatefulWidget {
  const QuotesGalleryPage({super.key});

  @override
  State<QuotesGalleryPage> createState() => _QuotesGalleryPageState();
}

class _QuotesGalleryPageState extends State<QuotesGalleryPage> {
  Map<String, List<QuoteGallery>> groupedQuotes = {};
  String selectedCategory = "";
  bool showAll = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    groupedQuotes = await QuoteGalleryService.fetchGallery();
    setState(() {
      selectedCategory = groupedQuotes.keys.first;
      isLoading = false;
    });
  }

  void _showQuotePopup(String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              // ==== IMAGE PREVIEW ====
              Center(child: InteractiveViewer(child: Image.network(imageUrl))),

              // ==== CLOSE BUTTON ====
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // ==== SHARE BUTTON ====
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.white, size: 28),
                  onPressed: () {
                    Share.share(imageUrl);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final quotes = groupedQuotes[selectedCategory] ?? [];
    final displayQuotes = showAll ? quotes : quotes.take(4).toList();

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

            // ================= CATEGORIES =================
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: groupedQuotes.keys.length,
                itemBuilder: (context, i) {
                  final c = groupedQuotes.keys.elementAt(i);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = c;
                        showAll = false;
                      });
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

            // ================= QUOTES LIST ================
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
                    // ==== GRID ====
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
                        final imageUrl = displayQuotes[index].images;

                        return GestureDetector(
                          onTap: () => _showQuotePopup(imageUrl),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
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
                              child: Image.network(imageUrl, fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // ==== SHOW MORE ====
                    if (quotes.length > 4)
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() => showAll = !showAll);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9D9D9),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            showAll ? "Show Less" : "Show More",
                            style: const TextStyle(
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

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
