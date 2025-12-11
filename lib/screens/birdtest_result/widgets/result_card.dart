import 'package:flutter/material.dart';
import '../../birdtest/birdtest_screen.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> result;
  final String nama;

  const ResultCard({super.key, required this.result, required this.nama});

  // ===== COLOR MAP =====
  Color getBirdColor(String bird) {
    switch (bird.toLowerCase()) {
      case "dove":
        return Colors.orange;
      case "peacock":
        return Colors.blue;
      case "eagle":
        return Colors.red;
      case "owl":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  // ===== WIDGET TITLE BERWARNA (HANDLE COMBINATION + EXTREME) =====
  Widget buildColoredTitle(String description) {
    // EXTREME
    if (description.toLowerCase().contains("extreme")) {
      String bird = description.replaceAll("Extreme ", "").trim();
      return Text(
        description.toUpperCase(),
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: getBirdColor(bird),
        ),
      );
    }

    // COMBINATION
    if (description.contains("-")) {
      final parts = description.split("-");
      return Row(
        children: [
          Text(
            parts[0].toUpperCase(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: getBirdColor(parts[0]),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            "-",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Text(
            parts[1].toUpperCase(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: getBirdColor(parts[1]),
            ),
          ),
        ],
      );
    }

    // SINGLE TYPE
    return Text(
      description.toUpperCase(),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: getBirdColor(description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ================= CARD ATAS =================
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  result['icon'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 16),

                /// TITLE BIRD TYPE (Uppercase + Colored)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Anda Adalah Seorang',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // 🔥 BIRD TITLE CUSTOM
                      buildColoredTitle(result['description']),

                      const SizedBox(height: 4),

                      Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// ================= CARD BAWAH =================
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== KELEBIHAN =====
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Kelebihan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(result['strength'], textAlign: TextAlign.left),

                const SizedBox(height: 20),

                /// ===== KEKURANGAN =====
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Kekurangan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(result['weakness'], textAlign: TextAlign.left),

                const SizedBox(height: 24),

                /// ===== BUTTON =====
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BirdtestPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.repeat, color: Colors.white),
                    label: const Text(
                      'Ambil Tes Lagi',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
