import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final int currentPage;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const NavigationButtons({
    super.key,
    required this.currentPage,
    required this.isLastPage,
    required this.onNext,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ================= BACK =================
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.arrow_back),
            label: const Text("Sebelumnya"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade400),
              shape: const StadiumBorder(),
            ),
            onPressed: currentPage == 0 ? null : onBack,
          ),
        ),

        const SizedBox(width: 12),

        // ================= NEXT / SUBMIT =================
        Expanded(
          child: OutlinedButton.icon(
            icon: Icon(isLastPage ? Icons.check : Icons.arrow_forward),
            label: Text(isLastPage ? "Kirim" : "Berikutnya"),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 223, 32, 32),
              side: BorderSide(color: Colors.grey.shade400),
              shape: const StadiumBorder(),
            ),
            onPressed: isLastPage ? onSubmit : onNext,
          ),
        ),
      ],
    );
  }
}
