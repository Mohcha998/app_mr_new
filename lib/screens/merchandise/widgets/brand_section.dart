import 'package:flutter/material.dart';
import 'brand_item.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Brands",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              BrandItem("assets/images/mrshop.png"),
              BrandItem("assets/images/manzone.png"),
              BrandItem("assets/images/primer.png"),
            ],
          ),
        ],
      ),
    );
  }
}
