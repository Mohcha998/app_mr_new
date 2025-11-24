import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/article_model.dart';
import '../../../services/article_service.dart';

class HomeNewsSection extends StatefulWidget {
  const HomeNewsSection({super.key});

  @override
  State<HomeNewsSection> createState() => _HomeNewsSectionState();
}

class _HomeNewsSectionState extends State<HomeNewsSection> {
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = ArticleService.getLatestArticles();
  }

  // =====================================================================
  // FUNCTION → Membuka artikel dengan format slug
  // =====================================================================
  void _openArticle(Article article) async {
    String slug = article.title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9 ]'), '') // hapus simbol
        .replaceAll(" ", "-")
        .trim();

    final Uri url = Uri.parse(
      "https://article.merryriana.com/id/article/$slug",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Gagal membuka URL: $url");
    }
  }

  // =====================================================================
  // FUNCTION → Membuka halaman SEE ALL
  // =====================================================================
  void _openSeeAll() async {
    final Uri url = Uri.parse("https://article.merryriana.com/id");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Gagal membuka URL: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _futureArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error: ${snapshot.error}"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No articles available"),
          );
        }

        final articles = snapshot.data!;
        final first = articles[0];
        final second = articles.length > 1 ? articles[1] : null;
        final third = articles.length > 2 ? articles[2] : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================
            // HEADER
            // =====================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Up to Date",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "with ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Merry Riana",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 186, 28, 17),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ============================
                  // SEE ALL → klik buka web
                  // ============================
                  GestureDetector(
                    onTap: _openSeeAll,
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: () => _openArticle(first),
              child: _bigNewsCard(first),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (second != null)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _openArticle(second),
                        child: _smallNewsCard(second),
                      ),
                    ),
                  if (third != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _openArticle(third),
                        child: _smallNewsCard(third),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  // =====================================================================
  // BIG NEWS CARD
  // =====================================================================
  Widget _bigNewsCard(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Image.network(
                ArticleService.fullImageUrl(article.image),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 180, color: Colors.grey.shade300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.formattedDate,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // SMALL NEWS CARD
  // =====================================================================
  Widget _smallNewsCard(Article article) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Image.network(
              ArticleService.fullImageUrl(article.image),
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 120, color: Colors.grey.shade300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  article.formattedDate,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
