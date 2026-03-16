import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/banner_section.dart';
import '../widgets/brand_section.dart';
import '../widgets/category_section.dart';

class MerchandisePage extends StatefulWidget {
  const MerchandisePage({super.key});

  @override
  State<MerchandisePage> createState() => _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 22),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Merchandise",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              /// SEARCH
              // SearchBarWidget(
              //   onChanged: (value) {
              //     setState(() {
              //       keyword = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),

              /// CONTENT
              const BannerSection(),
              const SizedBox(height: 20),
              const BrandSection(),
              const SizedBox(height: 20),

              CategorySection(searchKeyword: keyword),
            ],
          ),
        ),
      ),
    );
  }
}
