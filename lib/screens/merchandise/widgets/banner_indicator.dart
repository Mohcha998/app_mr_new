import 'package:flutter/material.dart';

class BannerIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;

  const BannerIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.red : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
