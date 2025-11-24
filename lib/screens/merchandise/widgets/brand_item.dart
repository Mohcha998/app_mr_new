import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final String image;
  const BrandItem(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 65, // lebih kecil dari sebelumnya
      height: 65, // lebih kecil dari sebelumnya
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), // gambar jadi lebih kecil
        child: ClipOval(
          child: Image.asset(
            image,
            fit: BoxFit.contain, // tetap rapih untuk PNG besar
          ),
        ),
      ),
    );
  }
}
