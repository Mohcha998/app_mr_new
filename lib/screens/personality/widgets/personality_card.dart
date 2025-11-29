import 'package:flutter/material.dart';
import '../../../models/personality_model.dart';

class PersonalityCard extends StatelessWidget {
  final PersonalityTrait trait;
  final VoidCallback onTap;

  const PersonalityCard({super.key, required this.trait, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4FF), // ✅ warna tetap
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(width: 110, height: 110, child: Image.asset(trait.icon)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trait.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    trait.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Selengkapnya...",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
