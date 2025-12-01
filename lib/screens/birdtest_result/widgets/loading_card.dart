import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 8),
            Text('Memuat hasil tes...'),
          ],
        ),
      ),
    );
  }
}
