import 'package:flutter/material.dart';

class BirdProgress extends StatelessWidget {
  final double progress;

  const BirdProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "(${progress.toStringAsFixed(0)}%)",
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
