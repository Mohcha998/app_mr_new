import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final String? image;
  final String? comingSoonLogo;
  final VoidCallback? onTap;
  final bool isComingSoon;

  const BrandItem._({
    this.image,
    this.onTap,
    this.isComingSoon = false,
    this.comingSoonLogo,
    super.key,
  });

  /// Normal brand item
  const BrandItem.image(this.image, {required this.onTap, super.key})
    : isComingSoon = false,
      comingSoonLogo = null;

  /// Coming Soon without logo
  const BrandItem.comingSoon({super.key})
    : image = null,
      onTap = null,
      isComingSoon = true,
      comingSoonLogo = null;

  /// Coming Soon WITH logo behind
  const BrandItem.comingSoonWithLogo(this.comingSoonLogo, {super.key})
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
        child: isComingSoon
            ? Stack(
                alignment: Alignment.center,
                children: [
                  if (comingSoonLogo != null)
                    Opacity(
                      opacity: 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          comingSoonLogo!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                  const Text(
                    "COMING\nSOON",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(image!, fit: BoxFit.contain),
              ),
      ),
    );
  }
}
