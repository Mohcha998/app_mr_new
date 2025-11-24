import 'package:flutter/material.dart';
import './widgets/search_bar.dart';
import './widgets/banner_section.dart';
import './widgets/brand_section.dart';
import './widgets/category_section.dart';

class MerchandisePage extends StatelessWidget {
  const MerchandisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 HEADER: Back + Title (center)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Stack(
                  children: [
                    // BACK BUTTON (KIRI)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 22,
                        color: Colors.black,
                      ),
                    ),

                    // TITLE (TENGAH)
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Merchandise",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // SEARCH BAR
              const SearchBarWidget(),
              const SizedBox(height: 20),

              // BANNER
              const BannerSection(),
              const SizedBox(height: 20),

              // BRANDS
              const BrandSection(),
              const SizedBox(height: 20),

              // CATEGORIES
              const CategorySection(),
            ],
          ),
        ),
      ),
    );
  }
}
