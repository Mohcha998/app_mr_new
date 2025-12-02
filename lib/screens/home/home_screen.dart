import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/quote_model.dart';
import '../../models/user_model.dart';
import '../../models/youtube_video_model.dart';
import '../../services/quote_service.dart';
import '../../services/youtube_service.dart';
import '../quote/edit_image_screen.dart';
import '../connect/connect_screen.dart';
import '../videos/videos_screen.dart';
import '../quote-gallery/quote_gallery_screen.dart';
import '../free-resource/free_resource_screen.dart';
import '../merchandise/merch_screen/merchandise_screen.dart';
import '../audio/audio_screen.dart';
import '../personality/personality_screen.dart';
import 'widgets/ads_popup.dart';
import '../../services/ads_popup_service.dart';
import '../../models/ads_popup_model.dart';

// import 'widgets/bottom_navbar.dart';
import 'widgets/home_news_section.dart';
import '../quote/quote_preview_page.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Quote> _quoteFuture;
  late Future<List<YoutubeVideo>> _futureVideos;

  bool _hasShownPopup = false;
  AdsPopupModel? _popupData;

  @override
  void initState() {
    super.initState();

    _quoteFuture = QuoteService().getTodayQuote(widget.user.id);
    _futureVideos = YoutubeService.getLatestVideos();

    // LOAD POPUP ADS
    AdsService.getPopup().then((data) {
      if (data != null && !_hasShownPopup) {
        _hasShownPopup = true;
        _popupData = data;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => AdsPopup(imageUrl: data.imageUrl),
          );
        });
      }
    });
  }

  void _shareQuote(Quote quote) async {
    final message =
        '"${quote.text}"\n\n— ${quote.author ?? "Merry Riana"}\n\n#MerryRiana #Inspiration';

    try {
      final byteData = await rootBundle.load('assets/images/signature.png');
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/signature.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      await Share.shareXFiles([XFile(file.path)], text: message);
    } catch (e) {
      Share.share(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// FIXED: user wajib dikirim ke BottomNavbar
      // bottomNavigationBar: BottomNavbar(currentIndex: 0, user: widget.user),
      body: SafeArea(
        child: FutureBuilder<Quote>(
          future: _quoteFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final quote = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // =========================
                  // Quote Card
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuotePreviewPage(quote: quote),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/images/9.jpg",
                                  width: double.infinity,
                                  height: 500,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 500,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              quote.text,
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Image.asset(
                                            'assets/images/signature.png',
                                            height: 40,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ------------ SHARE + EDIT ICONS ------------
                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: Row(
                            children: [
                              // SHARE
                              GestureDetector(
                                onTap: () => _shareQuote(quote),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.share, size: 20),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // EDIT
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const EditImagePage(),
                                      settings: RouteSettings(
                                        arguments: {'quote': quote},
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.edit, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9D9D9),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          "Show More",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // =========================
                  // GRID MENU
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      children: [
                        _menuItem("assets/icon/merch.png", "Merchandise", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MerchandisePage(),
                            ),
                          );
                        }),

                        _menuItem("assets/icon/program.png", "Program", () {}),

                        _menuItem("assets/icon/ps.png", "Personality Test", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PersonalityPage(),
                            ),
                          );
                        }),

                        _menuItem("assets/icon/video.png", "Video", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VideosScreen(),
                            ),
                          );
                        }),

                        _menuItem("assets/icon/audio.png", "Audio", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AudioPage(),
                            ),
                          );
                        }),

                        _menuItem("assets/icon/fr.png", "Free Resources", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FreeResourcesPage(),
                            ),
                          );
                        }),

                        _menuItem("assets/icon/connect.png", "Connect", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConnectWithMerryPage(),
                            ),
                          );
                        }),

                        _menuItem("assets/icon/info.png", "Info", () {}),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const HomeNewsSection(),
                  const SizedBox(height: 24),

                  // =========================
                  // FEATURED VIDEO
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Featured ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: "Video",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 186, 28, 17),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VideosScreen(),
                              ),
                            );
                          },
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

                  FutureBuilder<List<YoutubeVideo>>(
                    future: _futureVideos,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (snap.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text("Error: ${snap.error}"),
                        );
                      }

                      final videos = snap.data!;

                      return SizedBox(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: videos.length,
                          itemBuilder: (context, i) {
                            final v = videos[i];

                            return Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  v.thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // =========================
                  // QUOTES GALLERY
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Quotes ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 186, 28, 17),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: "Gallery",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuotesGalleryPage(),
                              ),
                            );
                          },
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: 6,
                      itemBuilder: (context, i) {
                        final int index = (i % 4) + 1;
                        final String url =
                            "https://merryriana.com/server_api/asset/quotes/$index.jpg";

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _menuItem(String iconPath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color.fromARGB(255, 194, 12, 12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(iconPath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
