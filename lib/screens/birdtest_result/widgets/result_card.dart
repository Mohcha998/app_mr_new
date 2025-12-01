import 'package:flutter/material.dart';
import '../../birdtest/birdtest_screen.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> result;
  final String nama;

  const ResultCard({super.key, required this.result, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Hasil Bird Test',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              nama,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Image.asset(
              result['icon'],
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text(
              'Anda Adalah Seorang',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              result['description'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kelebihan:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(result['strength']),
                const SizedBox(height: 12),
                const Text(
                  'Kekurangan:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(result['weakness']),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BirdtestPage()),
                );
              },
              icon: const Icon(Icons.repeat),
              label: const Text('Ambil Tes Lagi'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
