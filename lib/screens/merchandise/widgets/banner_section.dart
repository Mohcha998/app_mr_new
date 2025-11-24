import 'package:flutter/material.dart';
import 'banner_indicator.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({super.key});

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // memakai asset lokal
  final List<String> bannerImages = [
    "assets/banner/sale1.jpg",
    "assets/banner/sale2.jpg",
    "assets/banner/sale3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: bannerImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(bannerImages[index], fit: BoxFit.cover),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          BannerIndicator(
            length: bannerImages.length,
            currentIndex: _currentIndex,
          ),
        ],
      ),
    );
  }
}
