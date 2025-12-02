import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final String? image;
  final VoidCallback? onTap;
  final bool isComingSoon;

  const BrandItem._({
    this.image,
    this.onTap,
    this.isComingSoon = false,
    super.key,
  });

  const BrandItem.image(this.image, {required this.onTap, super.key})
    : isComingSoon = false;

  const BrandItem.comingSoon({super.key})
    : image = null,
      onTap = null,
      isComingSoon = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isComingSoon ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isComingSoon ? Colors.black.withOpacity(0.55) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: isComingSoon
            ? const Text(
                "COMING\nSOON",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: 0.8,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(image!, fit: BoxFit.contain),
              ),
      ),
    );
  }
}
